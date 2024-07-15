// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:tut/components/my_button.dart';
import 'package:tut/components/my_textfield.dart';
import 'package:tut/components/reportButton.dart';
import 'package:tut/pages/home.dart';

class registerPage extends StatefulWidget {

  final Function()? onTap;

  const registerPage({super.key, required this.onTap}); 
  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
 // Corrected constructor
  final userNamecontroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNamecontroller = TextEditingController();
  final lastNamecontroller = TextEditingController();
  final phoneNumberController = TextEditingController();


  // User Sign up method
  void userSignUp() async {
  // Loading circle
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(226, 48, 71, 1), // Custom color
        ),
      );
    },
    barrierDismissible: false, // Prevent dismissing the dialog
  );

  // TRY TO CREATE IN
  try {
    // Confirm passwords match
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      addUserDetails(
        firstNamecontroller.text.trim(),
        lastNamecontroller.text.trim(),
        emailController.text.trim(),
        int.parse(phoneNumberController.text.trim()),
      );

      // POP LOADING CIRCLE
      Navigator.pop(context);

      
    } else {
      Navigator.pop(context); // Ensure to pop the loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Passwords do not match. Please try again.'),
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    String errorCode = e.code;
    // POP LOADING CIRCLE
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorCode), // Wrap errorCode in Text widget
      ),
    );
  }
}


  Future addUserDetails(String firstNamecontroller, String lastNamecontroller, String emailController, int phoneNumberController) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstNamecontroller,
      'last name': lastNamecontroller,
      'email': emailController,
      'phone number': phoneNumberController,
    
    });
  }
  bool passwordConfirmed(){
      if (passwordController.text.trim() == confirmPasswordController.text.trim()){
        return true;
      }
      else{
        return false;
      }
    }

  @override
  void dispose(){
    emailController.dispose();
  }
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
                'Lets make a reach account',
                style: TextStyle(
                  color: Color.fromRGBO(226, 48, 71, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),

              // Description
              SizedBox(height: 35,),
              
              // User Name
              // Row(
              //   children: [
              //     Expanded(
              //       child: MyTextField(
              //         controller: firstNamecontroller, // Ensure this is the correct controller
              //         hintText: 'First Name',
              //         obscureText: false,
              //       ),
              //     ),
              //     SizedBox(width: 10), // Add spacing between the fields if needed
              //     Expanded(
              //       child: MyTextField(
              //         controller: lastNamecontroller, // Use a different controller for the last name
              //         hintText: 'Last Name',
              //         obscureText: false,
              //       ),
              //     ),
              //   ],
              // ),

              // First and last name
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: EdgeInsets.all(12)),
                    Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      controller: firstNamecontroller,
                      expands: false,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Color.fromRGBO(226, 48, 71, 1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                        ),
                        fillColor: Color.fromRGBO(255, 112, 129, 205),
                        filled: true,
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      obscureText: false,
                    ),
                  ),
                ),
                    SizedBox(width: 10), // Add spacing between the fields if needed
                  Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: TextFormField(
                      controller: lastNamecontroller,
                      expands: false,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 254, 254, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Color.fromRGBO(226, 48, 71, 1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                        ),
                        fillColor: Color.fromRGBO(255, 112, 129, 205),
                        filled: true,
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      obscureText: false,
                    ),
                  ),
                ),
                  ],
                ),
              ),


              SizedBox(height: 10,),


              // Email Address
              MyTextField(
                controller: emailController,
                hintText: 'Email address',
                obscureText: false,
                textFieldIcon: Icons.ac_unit,
                
              ),

              SizedBox(height: 10,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: IntlPhoneField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
                    ),
                    fillColor: Color.fromRGBO(255, 112, 129, 205),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.phone_iphone_rounded, color: Color.fromRGBO(226, 48, 71, 1)),
                  ),
                  initialCountryCode: 'US',
                  onChanged: (phone) {
                    print(phone.completeNumber); // You can use phone.completeNumber for the full number
                  },
                ),
              ),

              SizedBox(height: 10,),
              
              // Password
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: false,
                textFieldIcon: Icons.account_balance_wallet,
              ), 
              
              SizedBox(height: 10,),
      
              // Confirm Password
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: false,
                textFieldIcon: Icons.account_balance_wallet_sharp,
              ), 
              
              SizedBox(height: 10,),

              SizedBox(height: 100,),

              // sign-in button
              MyButton(
                onTap: userSignUp,
                text: 'Sign up',
              ),
              SizedBox(height: 20,),


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
