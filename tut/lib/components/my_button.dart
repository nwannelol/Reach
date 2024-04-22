// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
      
        padding: EdgeInsets.symmetric(vertical: 15, horizontal:32),
        
        margin: EdgeInsets.symmetric(horizontal: 100),
        
        decoration: BoxDecoration(color: Color(0xFF005FFF),
        
        borderRadius: BorderRadius.circular(30)),
        
        child: Center(
          child: Text(text,
          style: const TextStyle(color: Color.fromRGBO(255, 255, 255, 1), 
          fontWeight: FontWeight.bold, 
          fontSize: 14),),
        ),
      ),
    );
  }
}
