import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationsHandler {
  void printToken() async {
    await FirebaseMessaging.instance.requestPermission();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
  }
}
