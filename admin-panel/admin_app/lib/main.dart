import 'package:admin_app/const/constant.dart';
import 'package:admin_app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/style/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reach Admin Dashboard',
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: AdminAppColors.primaryBg,
        brightness: Brightness.dark
        
        
      ),
    );
  }
}
