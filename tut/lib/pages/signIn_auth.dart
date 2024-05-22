import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tut/pages/home.dart';
import 'package:tut/pages/log-reg.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), // The stream listens to the state changes in the firebase auth state
        builder: ((context, snapshot) {
          // Signed in
          if (snapshot.hasData){
          return HomePage();
        }
          // Not signed in
          else{
            return const logReg();
          }
        }
        )),
    );
  }
}