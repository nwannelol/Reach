// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  

  const MyTextField({
    super.key, // Specify the key parameter correctly
    required this.controller,
    required this.hintText,
    required this.obscureText,

  }); // Call the superclass constructor with the key parameter

  @override
  Widget build(BuildContext context) {
    return Padding( // Remove const from Padding widget
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: Color.fromRGBO(226, 48, 71, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
          ),
          fillColor: Color.fromRGBO(255, 112, 129, 205),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          
        ),
      ),
    );
  }
}
