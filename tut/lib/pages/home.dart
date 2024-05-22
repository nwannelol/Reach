import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tut/components/bottom_navbar.dart';
// Import your reportFloatingActionButton widget
 // Assuming it's in a components folder
import 'package:location/location.dart' as location;
import 'package:tut/components/reportButton.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0F111A),
      body: Center(
        child: Text(
          'USER LOGGED IN: ${user.email!}!',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(226, 48, 71, 1),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Replace FloatingActionButtonWidget() with reportFloatingActionButton
      floatingActionButton: reportFloatingActionButton(context: context,),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
