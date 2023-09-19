import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as crypto from 'crypto';
import Razorpay from 'razorpay';
import * as moment from 'moment-timezone';

admin.initializeApp();

const razorpay = new Razorpay({
    key_id: 'rzp_test_w1r1PYTH0wy118',
    key_secret: 'TL2uYZPe5DoDOcaaP4Zr8ua1'
});

const processRefund = functions.https.onRequest(async (request, response) => {
    const orderId = request.body.orderId;
    const mobileNo = request.body.userId;
    let paymentDetails;
    const userDocRef = admin.firestore().collection('users').doc(mobileNo);
    const bookingDocRef = userDocRef.collection('bookings').doc(orderId);
    try {
        const booking = await bookingDocRef.get();

        if (booking.exists) {
            const bookingData = booking.data();
            console.log("Booking Data:", bookingData);

            if (bookingData?.[orderId].paymentStatus == 'success') {
                const paymentDetail = (await bookingDocRef.collection('paymentDetails').doc('paymentDetails').get()).data();
                paymentDetails = paymentDetail?.paymentDetails.id;
                 response.status(200).json({ success: 'order refund in progress' });
            }else if(bookingData?.[orderId].paymentStatus !== 'success'){
                console.error("Booking status is not 'success'");
                response.status(400).json({ error: 'We cannot process refund for this orderId' });
                return;
            }

            try {
                const refund = await razorpay.payments.refund(paymentDetails, {});
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
            const paymentDetails = req.body.payload.payment.entity;

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            const fieldPath = `${description}.paymentStatus`;

            bookingDocRef.update({ [fieldPath]: "success" })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentDetails').doc('paymentDetails').set({ paymentDetails: paymentDetails })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                
        } else if (event === 'payment.failed') {
            const mobileNo = req.body.payload.payment.entity.contact;
            const description = req.body.payload.payment.entity.description;
            const paymentDetails = req.body.payload.payment.entity;

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            const fieldPath = `${description}.paymentStatus`;

            bookingDocRef.update({ [fieldPath]: "failed" })
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentDetails').doc('paymentDetails').set({ paymentDetails: paymentDetails })
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
            const paymentStatus = `${description}.paymentStatus`;
            const fieldPathForBookingStatus = `${description}.checkOutStatus`;
            
            bookingDocRef.get().then((documentSnapshot) => {
                if (documentSnapshot.exists) {
                    // Document data will be available in documentSnapshot.data()
                    const paymentStatusValue = documentSnapshot.get(paymentStatus);
                    console.log('Payment Status:', paymentStatusValue);
                    if(paymentStatusValue === "success"){
                        bookingDocRef.update({[paymentStatus]: "processing refund"})
                        .then(() => {
                            res.status(200).send('OK');
                        })
                        .catch(error => {
                            console.error('Error updating database:', error);
                            res.status(500).send('Internal server error');
                        });
                    }
                    bookingDocRef.update({[fieldPathForBookingStatus]:'cancelled'  })
                        .then(() => {
                            res.status(200).send('OK');
                        })
                        .catch(error => {
                            console.error('Error updating database:', error);
                            res.status(500).send('Internal server error');
                        });
                    bookingDocRef.collection('paymentDetails').doc('paymentDetails').update({ refundDetails: refundDetails })
                    .then(() => {
                        res.status(200).send('OK');
                    })
                    .catch(error => {
                        console.error('Error updating database:', error);
                        res.status(500).send('Internal server error');
                    });
                } else {
                    console.error("No such document!");
                }
             }).catch((error) => {
                console.error("Error fetching document:", error);
             });
        } else if (event === 'refund.processed') {
            const mobileNo = req.body.payload.payment.entity.contact;
            const description = req.body.payload.payment.entity.description;
            const refundDetails = req.body.payload.refund.entity;

            const userDocRef = admin.firestore().collection('users').doc(mobileNo);
            const bookingDocRef = userDocRef.collection('bookings').doc(description);
            const fieldPath = `${description}.paymentStatus`;
            console.error(refundDetails);
            bookingDocRef.update({ [fieldPath]: "refund processed"})
                .then(() => {
                    res.status(200).send('OK');
                })
                .catch(error => {
                    console.error('Error updating database:', error);
                    res.status(500).send('Internal server error');
                });
                bookingDocRef.collection('paymentDetails').doc('paymentDetails').update({ processedRefundDetails: refundDetails })
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

const fetchRatingsDaily = functions.pubsub
    .schedule('0 0 * * *')
    .timeZone('Asia/Kolkata') // Set to Indian Standard Time
    .onRun(async (context) => {
    try {
        // Get the current date and time in IST
const nowInIST = moment.tz("Asia/Kolkata");

// Subtract one day to get yesterday's date
const yesterdayInIST = nowInIST.subtract(1, 'days');

// Format the date
const formattedYesterdayDate = yesterdayInIST.format('DD-MM-yyyy');
      const collectionsSnapshot = await admin.firestore().listCollections();

      for (const collectionRef of collectionsSnapshot) {
        const collectionId = collectionRef.id;
        
        // Skip the "users" collection
        if (collectionId === 'users' || collectionId == 'discounts') {
          continue;
        }

        const documentsSnapshot = await collectionRef.get();

        for (const documentSnapshot of documentsSnapshot.docs) {
          const hotelsCollectionRef = documentSnapshot.ref.collection('hotels');
          const hotelsDocumentsSnapshot = await hotelsCollectionRef.get();

          for (const hotelDocumentSnapshot of hotelsDocumentsSnapshot.docs) {
            const ratingsCollectionRef = hotelDocumentSnapshot.ref.collection('ratings');
                    // Fetch ratings documents created yesterday
                    const ratingsSnapshot = await ratingsCollectionRef
                        .where('ratings.timeStamp', '==', formattedYesterdayDate)
                        .get();
                        console.log(formattedYesterdayDate);
                        
            const ratings: number[] = []; // Array to store rating values
            
            ratingsSnapshot.forEach((ratingDoc) => {
              const ratingData = ratingDoc.data();
              const ratingValue = ratingData.ratings.rating;
              ratings.push(ratingValue);
            });

            const valueOfOneStarRating = ratings.filter(rating => rating === 1).length;
            const valueOfTwoStarRating = ratings.filter(rating => rating === 2).length;
            const valueOfThreeStarRating = ratings.filter(rating => rating === 3).length;
            const valueOfFourStarRating = ratings.filter(rating => rating === 4).length;
            const valueOfFiveStarRating = ratings.filter(rating => rating === 5).length;
            const sumOfAllNewRating = ratings.reduce((sum, rating) => sum + rating, 0);
            const countOfNewRatings = ratings.length;

            // Get the document ID as the field name
            const fieldName = hotelDocumentSnapshot.id;

            // Access the nested field "ratings" using data() method
            const fieldData = hotelDocumentSnapshot.data();

            // Using optional chain expression to access nested "ratings" field
            const ratingsData = fieldData?.[fieldName]?.ratings;

            if (ratingsData !== undefined) {
                const totalCurrentRatings = (ratingsData.oneStarRatingsCount + ratingsData.twoStarRatingsCount + 
                                            ratingsData.threeStarRatingsCount + ratingsData.fourStarRatingsCount + ratingsData.fiveStarRatingsCount);
                let calculatedAverage = ((ratingsData.averageRating * totalCurrentRatings) + sumOfAllNewRating) / (totalCurrentRatings + countOfNewRatings);

                // Check if the calculated average is NaN and set it to 0 if true
                ratingsData.averageRating = isNaN(calculatedAverage) ? 0 : calculatedAverage;
                                            
                ratingsData.oneStarRatingsCount = ratingsData.oneStarRatingsCount + valueOfOneStarRating;
                ratingsData.twoStarRatingsCount = ratingsData.twoStarRatingsCount + valueOfTwoStarRating;
                ratingsData.threeStarRatingsCount = ratingsData.threeStarRatingsCount + valueOfThreeStarRating;
                ratingsData.fourStarRatingsCount = ratingsData.fourStarRatingsCount + valueOfFourStarRating;
                ratingsData.fiveStarRatingsCount = ratingsData.fiveStarRatingsCount + valueOfFiveStarRating;
                ratingsData.noOfRatings = totalCurrentRatings + countOfNewRatings;
                await hotelDocumentSnapshot.ref.update({
                    [`${fieldName}.ratings`]: ratingsData
                });

            } else {
            console.error('Nested field "ratings" is missing or undefined in hotel document data.');
            }

          }
        }
      }
      return null;
    } catch (error) {
      console.error('Error fetching ratings:', error);
      return null;
    }
  });

  const processBookingDataForOnlinePayment = functions.https.onRequest(async (request, response) => {
    const userId = request.body.userId;
    const bookingId = request.body.bookingId;
    request.body.paymentMode = "online";
    request.body.paymentStatus = "initiated";
    const userDocRef = admin.firestore().collection('users').doc(userId).collection("bookings").doc(bookingId);
    try {
       await userDocRef.set({[bookingId]: request.body});
       response.status(200).json("booking for cash payment is success");
    } catch (error) {
        console.error("Error:", error);
        response.status(500).json(error);
    }
});

const processBookingDataForCashPayment = functions.https.onRequest(async (request, response) => {
    const userId = request.body.userId;
    console.error(userId);
    const bookingId = request.body.bookingId;
    request.body.paymentMode = "cash";
    request.body.paymentStatus = "verified";
    const userDocRef = admin.firestore().collection('users').doc(userId).collection("bookings").doc(bookingId);
    try {
       await userDocRef.set({[bookingId]: request.body});
       response.status(200).json("booking for cash payment is success");
    } catch (error) {
        console.error("Error:", error);
        response.status(500).json(error);
    }
});

export { processRefund, handleRazorpayCallback, processRating,fetchRatingsDaily,processBookingDataForOnlinePayment, processBookingDataForCashPayment };

