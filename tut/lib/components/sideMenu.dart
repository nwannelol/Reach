import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Text(user as String),
            )
          ],
        ),
      ),
    );
  }
}