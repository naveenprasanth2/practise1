import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as crypto from 'crypto';

admin.initializeApp();

export const handleRazorpayCallback = functions.https.onRequest((req, res) => {
  const secret = 'TL2uYZPe5DoDOcaaP4Zr8ua1';
  const razorpaySignature = req.headers['x-razorpay-signature'] as string;
  const body = JSON.stringify(req.body);

  const generatedSignature = crypto.createHmac('sha256', secret).update(body).digest('hex');

  if (generatedSignature === razorpaySignature) {
    // signature is valid
    const event = req.body.event;

    if (event === 'payment.authorized') {
      // Extract email and contact from payload
      const mobileNo = req.body.payload.payment.entity.contact;
      const description = req.body.payload.payment.entity.description;
      const notesString = req.body.payload.payment.entity.notes;
        // Parse the valid notesString JSON
        let notes = {
            ...JSON.parse(notesString.paymentDetails),
            ...JSON.parse(notesString.hotelDetails),
            ...JSON.parse(notesString.bookingSchedule),
            ...JSON.parse(notesString.bookingStatus),
        };
      // Update Firestore database
      const userDocRef = admin.firestore().collection('users').doc(mobileNo); // Assuming mobile number is used as the user's ID
      const bookingDocRef = userDocRef.collection('bookings').doc(description);
      notes.status = "success";

      bookingDocRef.set({ description: notes })
        .then(() => {
          res.status(200).send('OK');
        })
        .catch(error => {
          console.error('Error updating database:', error);
          res.status(500).send('Internal server error');
        });
    } else {
      // ignore other events
      res.status(200).send('OK');
    }
  } else {
    // signature is not valid
    res.status(400).send('Signature not valid');
  }
});
