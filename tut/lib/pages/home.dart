import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:starsview/starsview.dart';
import 'package:tut/components/sideMenu.dart';
import 'package:tut/components/reportButton.dart'; // Adjust the import according to your file structure

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Report'),
      ),
      body: Stack(
        children: [
          StarsView(fps: 60), // Add your animated background here
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'TAP TO REPORT EMERGENCY',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(226, 48, 71, 1),
                    fontSize: 20.0,
                  ),
                ),
                const SizedBox(height: 40.0),
                const ReportFloatingActionButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
