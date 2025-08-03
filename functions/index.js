const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.sendOrderNotification = functions.firestore
  .document('orders/{orderId}')
  .onCreate(async (snap, context) => {
    const orderData = snap.data();
    const userName = orderData.name || 'Someone';
    const total = orderData.total || '';

    const payload = {
      notification: {
        title: 'New Order Placed!',
        body: `${userName} placed an order worth ₹${total}.`,
      },
    };

    try {
      // OPTIONAL: You can broadcast or use specific FCM tokens if stored
      const tokensSnapshot = await admin.firestore().collection('fcmTokens').get();
      const tokens = tokensSnapshot.docs.map(doc => doc.id);

      if (tokens.length === 0) {
        console.log('No device tokens available');
        return;
      }

      const response = await admin.messaging().sendToDevice(tokens, payload);
      console.log('Notifications sent successfully:', response.successCount);
    } catch (error) {
      console.error('Error sending notification:', error);
    }
  });
