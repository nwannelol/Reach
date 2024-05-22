import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tut/components/reportButton.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      color: const Color.fromARGB(255, 251, 251, 251),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Color.fromRGBO(226, 48, 71, 1)),
            onPressed: () {},
          ),
          const SizedBox(), // Creates the notch for the FloatingActionButton
          IconButton(
            icon: const Icon(Icons.person, color: Color.fromRGBO(226, 48, 71, 1)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}




void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget(),
      //floatingActionButton: reportFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Text('Content goes here')),
    ),
  ));
}
