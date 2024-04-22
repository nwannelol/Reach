// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tut/components/my_button.dart';
import 'package:tut/components/my_textfield.dart';

class registerPage extends StatefulWidget {

  final Function()? onTap;

  registerPage({super.key, required this.onTap}); 
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
 // Corrected constructor
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // User Sign up method
  void userSignUp() async {

    
    
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
    
    //TRY TO CREATE IN
    try {
      // Confirm passwords match
      if (passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text
    );
      }
      else{
        showErrorMessage('Passwords do not match');

      }
    
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
              SizedBox(height: 10),

              // Icon
              Icon(
                Icons.lock,
                size: 50,
                color: Color.fromRGBO(226, 48, 71, 1),
              ),

              // Title
              SizedBox(height: 25),
              Text(
                'Welcome to Reach! Lets make an account',
                style: TextStyle(
                  color: Color.fromRGBO(226, 48, 71, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Description
              SizedBox(height: 35,),
              
              // Email Address
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
      
              // Confirm Password
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Re-type Password',
                obscureText: false,
              ), 
              
              SizedBox(height: 10,),

              SizedBox(height: 25,),

              // sign-in button
              MyButton(
                onTap: userSignUp,
                text: 'Sign up',
              ),
              SizedBox(height: 100,),


              // register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: TextStyle(color: Colors.white)), 
                  SizedBox(width: 4,),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text('Login Here',
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
