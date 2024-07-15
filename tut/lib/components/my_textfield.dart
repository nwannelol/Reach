// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? textFieldIcon;
  final IconData? suffixIcon; // Make the icon parameter nullable

  const MyTextField({
    super.key, // Specify the key parameter correctly
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.textFieldIcon,
    this.suffixIcon
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0), // Adjust padding to reduce spacing
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          color: Color.fromRGBO(255, 254, 254, 1),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          prefixIcon: textFieldIcon != null ? Icon(textFieldIcon, color: Color.fromRGBO(226, 48, 71, 1)) : null,
          suffixIcon: suffixIcon != null ? Icon(textFieldIcon, color: Color.fromRGBO(226, 48, 71, 1)) : null, // Conditionally include the icon
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
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
        obscureText: obscureText,
      ),
    );
  }
}


// Padding( // Remove const from Padding widget
//       padding: EdgeInsets.symmetric(horizontal: 25.0),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(
//           color: Color.fromRGBO(226, 48, 71, 1),
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//         ),
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Color.fromRGBO(226, 48, 71, 1)),
//           ),
//           fillColor: Color.fromRGBO(255, 112, 129, 205),
//           filled: true,
//           hintText: hintText,
//           hintStyle: TextStyle(color: Colors.grey[500]),
          
//         ),
//       ),
//     );