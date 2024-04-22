import 'package:flutter/material.dart';
import 'package:tut/pages/login.dart';
import 'package:tut/pages/registerPage.dart';

class logReg extends StatefulWidget {
  const logReg({super.key});

  @override
  State<logReg> createState() => _logRegState();
}

class _logRegState extends State<logReg> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage == true){
        return LoginPage(onTap: togglePages,);
      }
    else {
      return registerPage(onTap: togglePages,);
    } 
  }
}