import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notification_app/fcm_handler.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseNotificationsHandler().printToken();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  TextEditingController dataController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('FCM'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Center(
                child: Text('Hi barbie'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  controller: dataController,
                  decoration: const InputDecoration(hintText: 'Add here'),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    FirestoreHandler()
                        .addToFirestore({"data": dataController.text}
                            as Map<String, dynamic>)
                        .then((value) {
                      print('success');
                      var snackBar = const SnackBar(
                        content: Text('Successful'),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }).onError((error, stackTrace) {
                      print(error.toString());
                      var snackBar = const SnackBar(
                        content: Text('Failure'),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    });
                    dataController.clear();
                  },
                  child: const Text('Add data'))
            ],
          ),
        ));
  }
}
