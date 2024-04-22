import 'package:flutter/material.dart';

class loadingScreen extends StatelessWidget {
  const loadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Color.fromRGBO(226, 48, 71, 1), // Your desired color
      ),
    );
  }
}
