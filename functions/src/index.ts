import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as crypto from 'crypto';
import Razorpay from 'razorpay';

admin.initializeApp();

const razorpay = new Razorpay({
    key_id: 'rzp_test_w1r1PYTH0wy118',
    key_secret: 'TL2uYZPe5DoDOcaaP4Zr8ua1'
});

const processRefund = functions.https.onRequest(async (request, response) => {
    const orderId = request.body.orderId;
    const mobileNo = request.body.userId;
    let paymentId;
    const userDocRef = admin.firestore().collection('users').doc(mobileNo);
    const bookingDocRef = userDocRef.collection('bookings').doc(orderId);
    try {
        const booking = await bookingDocRef.get();

        if (booking.exists) {
            const bookingData = booking.data();
            console.log("Booking Data:", bookingData);

            if (bookingData?.[orderId].status !== 'success') {
                console.error("Booking status is not 'success'");
                response.status(400).json({ error: 'We cannot process refund for this orderId' });
                return;
            }else if(bookingData?.[orderId].status == 'success'){
               const paymentDetails = (await bookingDocRef.collection('paymentId').doc('paymentId').get()).data();
                paymentId = paymentDetails?.paymentDetails.id;
                response.status(200).json({ success: 'order refund in progress' });
            }

            try {
                const refund = await razorpay.payments.refund(paymentId, {});
                response.json(refund);
            } catch (error) {
                response.status(500).json(error);
            }
        } else {
            console.log("Booking not found");
            response.status(404).json({ error: 'Booking not found' });
        }
    } catch (error) {
        console.error("Error:", error);
        response.status(500).json(error);
    }
});


const handleRazorpayCallback = functions.https.onRequest((req, res) => {
    const secret = 'TL2uYZPe5DoDOcaaP4Zr8ua1';
    const razorpaySignature = req.headers['x-razorpay-signature'] as string;
    const body = JSON.stringify(req.body);

    const generatedSignature = crypto.createHmac('sha256', secret).update(body).digest('hex');

    if (generatedSignature === razorpaySignature) {
        const event = req.body.event;

        if (event === 'payment.captured') {
            const mobileNo = req.body.payload.payment.entity.contact;
            const description = req.body.payload.payment.entity.description;
            const notesString = req.body.payload.payment.entity.notes;
            const paymentDetails = req.body.payload.payment.entity;
            console.log(paymentDetails);

            let notes = {
                ...JSON.parse(notesString.paymentDetails),
                ...JSON.parse(notesString.hotelDetails),
                ...JSON.parse(notesString.bookingSchedule),
                ...JSON.parse(notesString.bookingStatus),
            };

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            notes.status = "success";

            bookingDocRef.set({ [description]: notes })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentId').doc('paymentId').set({ paymentDetails: paymentDetails })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                
        } else if (event === 'refund.created') {
            const mobileNo = req.body.payload.payment.entity.contact;
            const description = req.body.payload.payment.entity.description;
            const refundDetails = req.body.payload.refund.entity;

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            const fieldPath = `${description}.status`;
            const fieldPathForBookingStatus = `${description}.checkOutStatus`;

            bookingDocRef.update({ [fieldPath]: "processing refund", [fieldPathForBookingStatus]:'cancelled'  })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentId').doc('paymentId').update({ refundDetails: refundDetails })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                
        } else if (event === 'refund.processed') {
            const mobileNo = req.body.payload.payment.entity.contact;
            const description = req.body.payload.payment.entity.description;
            const refundDetails = req.body.payload.refund.entity;

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            const fieldPath = `${description}.status`;
            console.error(refundDetails);
            bookingDocRef.update({ [fieldPath]: "refund processed"})
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentId').doc('paymentId').update({ processedRefundDetails: refundDetails })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                
        }else {
            res.status(200).send('OK');
        }
    } else {
        res.status(400).send('Signature not valid');
    }
});

const processRating = functions.https.onRequest(async (request, response) => {
    const bookingId = request.body.bookingHistoryModel.bookingId;
    const bookingHistoryModel = request.body.bookingHistoryModel;
    const ratingsModel = request.body.starRatingDetailsModel;
    const mobileNo = request.body.mobileNo;
    const userRatedStatus = admin.firestore().collection('users').doc(mobileNo).collection('bookings')
        .doc(bookingId);
        const snapshot = await userRatedStatus.get();
    
        if (!snapshot.exists) {
            console.error('Document not found');
            response.status(500).send('No corresponding booking id found for the user');
        }
    
        const data = snapshot.data();
        const rated = data ? data?.[bookingId].rated : null;  // Ensure the data exists before trying to access the ratings field
        const checkOutStatus = data ? data?.[bookingId].checkOutStatus : null;
        console.log(data?.[bookingId].rated);
    
    if(rated == false && checkOutStatus == 'checkedOut'){
        const ratingRefDoc = admin.firestore().collection(bookingHistoryModel.cityAndState
            .split(",")
            .pop()  // equivalent to .last
            .trim()
            .toLowerCase()).doc(bookingHistoryModel.cityAndState
                .split(",")
                [0]  // equivalent to .first in Dart
                .trim()
                .toLowerCase()).collection('hotels').doc(bookingHistoryModel.hotelId).collection('ratings').doc(bookingId);
                ratingRefDoc.set({ 'ratings': ratingsModel })
                .then(() => {
                    response.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    response.status(500).send('Internal server error');
                });
        const filePathToSetRating = `${bookingId}.rated`;
        userRatedStatus.update({ [filePathToSetRating]: true })
        .then(() => {
            response.status(200).send('OK');
        })
        .catch(error => {
            console.error('Error updating user rated status:', error);
            response.status(500).send('Internal server error');
        });
    }else{
        response.status(500).send('User cannot rate for this booking id');
    }

});

export { processRefund, handleRazorpayCallback, processRating };

