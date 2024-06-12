import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tut/components/imagePicker.dart';
import 'package:tut/components/my_button.dart';

class ReportFloatingActionButton extends StatefulWidget {
  const ReportFloatingActionButton({super.key});

  @override
  _ReportFloatingActionButtonState createState() => _ReportFloatingActionButtonState();
}

class _ReportFloatingActionButtonState extends State<ReportFloatingActionButton> {
  String? userEmergency;
  String? imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => _buildBottomSheet(context),
      ),
      backgroundColor: const Color.fromRGBO(226, 48, 71, 1),
      mini: true,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExpansionTile(
            title: ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Police Harassment'),
              onTap: () => handleEmergency(context, 'Harassment'),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: const Icon(Icons.local_police),
              title: const Text('Security'),
              onTap: () => _pickImage(context),
            ),
            onTap: () => _pickImage(context),
          ),
          ListTile(
            leading: const Icon(Icons.notification_important),
            title: const Text('Fire'),
            onTap: () => handleEmergency(context, 'Fire'),
          ),
        ],
      ),
    );
  }

  Future<void> handleEmergency(BuildContext context, String emergencyType) async {
    setState(() {
      userEmergency = emergencyType;
    });

    Navigator.pop(context); // Close the bottom sheet

    // Check and request location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle appropriately.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are required.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are permanently denied.')),
      );
      return;
    }

    final timestamp = Timestamp.now();

    Position? position;
    try {
      position = await _getLocation();
      if (position == null) {
        throw TimeoutException('Location timeout');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
      return;
    }

    // Show the location in a SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Current location: Lat: ${position.latitude}, Lon: ${position.longitude}')),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Successfully reported emergency. Please await official response.')),
    );

    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.uid;

    final locationDoc = {
      'emergencyType': userEmergency,
      'useruid': userId,
      'email': user.email,
      'location': GeoPoint(position.latitude, position.longitude),
      'timestamp': timestamp,
      'accuracy': position.accuracy,
    };

    await FirebaseFirestore.instance.collection('user-locations').add(locationDoc);
  }

  Future<Position?> _getLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).timeout(const Duration(seconds: 15));
    } on TimeoutException catch (e) {
      print('TimeoutException: ${e.message}');
      return null;
    } catch (e) {
      print('An unexpected error occurred: $e');
      return null;
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    // Request camera and storage permissions
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      // Permission granted
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery, // Change to ImageSource.camera for camera
      );

      if (pickedFile != null) {
        // Handle picked image or document (replace with your upload logic)
        print('Picked file path: ${pickedFile.path}');
        // ... your upload logic
      } else {
        print('No image or document selected.');
      }
    } else {
      // Permission denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera and storage permissions are required.'),
        ),
      );
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: Scaffold(
      floatingActionButton: ReportFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: Text('Content goes here')),
    ),
  ));
}
