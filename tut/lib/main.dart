import 'package:flutter/material.dart';
import 'package:tut/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tut/pages/signIn_auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Corrected constructor declaration

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Auth(),
    );
  }
}
