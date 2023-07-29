const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);
let msgData;

exports.offerTrigger = functions.firestore.document("orders/{orderId}").onCreate((snapshot, context) => {
  msgData = snapshot.data();

  admin.firestore().collection("tokens").get().then((snapshots) => {
    const tokens = [];
    if (snapshots.empty) {
      console.log("No Devices Found");
    } else {
      snapshots.forEach((doc) => {
        tokens.push(doc.data().token);
      });

      const payload = {
        "notification": {
          "title": "From " + msgData.data,
          "body": "Offer is : ",
          "sound": "default",
        },
      };

      return admin.messaging().sendToDevice(tokens, payload)
        .then((response) => {
          console.log("pushed them all");
        })
        .catch((err) => {
          console.log(err);
        });
    }
  });
});
