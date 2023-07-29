import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseNotificationsHandler {
  void printToken() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }
}

class FirestoreHandler {
  final db = FirebaseFirestore.instance;
  Future<void> addToFirestore(Map m) async {
    db.collection('orders').add(m as Map<String, dynamic>);
  }
}
