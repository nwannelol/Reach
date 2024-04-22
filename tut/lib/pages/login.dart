// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tut/components/bottom_navbar.dart';
import 'package:tut/components/my_button.dart';
import 'package:tut/components/my_textfield.dart';

class LoginPage extends StatefulWidget {

  final Function()? onTap;

  LoginPage({super.key, required this.onTap}); 
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 // Corrected constructor
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // User Sign in method
  void userSignIn() async {
    
    //Loading circle
    showDialog(
    context: context,
    builder: (context){ 
      return Center(
      child: CircularProgressIndicator(
        color: Color.fromRGBO(226, 48, 71, 1), // Custom color
      ),
    );
    }
  );
    
    //TRY TO SIGN IN
    try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text, 
    password: passwordController.text
    );
    
    // POP LOADING CIRCLE
      Navigator.pop(context);
} 
    on FirebaseAuthException catch (e) {

      // POP LOADING CIRCLE
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFF0F111A),
      resizeToAvoidBottomInset: false,
      
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),

              // Icon
              Icon(
                Icons.lock,
                size: 100,
                color: Color.fromRGBO(226, 48, 71, 1),
              ),

              // Title
              SizedBox(height: 50),
              Text(
                'Welcome to Reach!',
                style: TextStyle(
                  color: Color.fromRGBO(226, 48, 71, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Description
              SizedBox(height: 35,),
              // Username
              MyTextField(
                controller: emailController,
                hintText: 'Email address',
                obscureText: false,
              ),

              SizedBox(height: 10,),
              
              // Password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ), 
              
              SizedBox(height: 10,),
              
              // Forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?', 
                    style: TextStyle(color: Color.fromRGBO(226, 48, 71, 1)) ,),
                  ],
                ),
              ),

              SizedBox(height: 25,),

              // sign-in button
              MyButton(
                onTap: userSignIn,
                text: 'Sign In',
              ),
              SizedBox(height: 100,),


              // Sign in with other services


              // register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?', style: TextStyle(color: Colors.white)), 
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Register Here',
                    style: TextStyle(color: Color.fromRGBO(226, 48, 71, 1), 
                    fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            

            ],
          ),
        ),
      ),
    );
  }
  
  void showErrorMessage(String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(226, 48, 71, 1),
        contentPadding: const EdgeInsets.all(25.0),
        title: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Dismiss the dialog
            child: Text('Dismiss message', style: TextStyle(color: Colors.white),),
          ),
        ],
      );
    },
  );
}

}

  
