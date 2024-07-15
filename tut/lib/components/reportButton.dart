import 'dart:async';
import 'dart:io';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:google_fonts/google_fonts.dart';
import 'package:starsview/starsview.dart';
import 'data_firestore.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

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

class ReportFloatingActionButton extends StatefulWidget {
  const ReportFloatingActionButton({super.key});

  @override
  _ReportFloatingActionButtonState createState() => _ReportFloatingActionButtonState();
}

class _ReportFloatingActionButtonState extends State<ReportFloatingActionButton> {
  String? userEmergency;
  final FirestoreService _firestoreService = FirestoreService();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      glowColor: const Color.fromRGBO(226, 48, 71, 1),
      animate: true,
      duration: const Duration(milliseconds: 2000),
      repeat: true,
      child: Material(
        elevation: 8.0,
        shape: const CircleBorder(),
        child: GestureDetector(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => _buildBottomSheet(context),
          ),
          child: Container(
            width: 150.0,  // Increased width
            height: 150.0, // Increased height
            decoration: BoxDecoration(
              color: const Color.fromRGBO(226, 48, 71, 1),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.add,
              size: 80.0,  // Increased icon size
              color: Colors.white,
            ),
          ),
        ),
      ),
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
              onTap: () => _handleEmergency('Harassment'),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: const Icon(Icons.local_police),
              title: const Text('Security'),
              onTap: () => _pickImage(),
            ),
            onTap: () => _pickImage(),
          ),
          ListTile(
            leading: const Icon(Icons.notification_important),
            title: const Text('Fire'),
            onTap: () => _handleEmergency('Fire'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleEmergency(String emergencyType) async {
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
        _showSnackBar('Location permissions are required.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _showPermissionsDialog();
      return;
    }

    Position? position;
    try {
      position = await _getLocation();
      if (position == null) {
        throw TimeoutException('Location timeout');
      }
    } catch (e) {
      _showSnackBar('Failed to get location: $e');
      return;
    }

    // Show the location in a SnackBar
    _showSnackBar('Current location: Lat: ${position.latitude}, Lon: ${position.longitude}');
    _showSnackBar('Successfully reported emergency. Please await official response.');

    try {
      await _firestoreService.reportEmergency(emergencyType, position);
      print('Emergency data successfully sent to Firestore.');
    } catch (e) {
      print('Failed to send emergency data to Firestore: $e');
      _showSnackBar('Failed to send emergency data: $e');
    }
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

  void _showPermissionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permissions Required'),
          content: const Text(
              'Location permissions are permanently denied. Please enable them in the app settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage() async {
    final cameraStatus = await Permission.camera.request();
    final storageStatus = await Permission.storage.request();

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null) {
        try {
          String downloadUrl = await _uploadImageToFirebase(pickedFile);
          print('Image uploaded: $downloadUrl');
          _showSnackBar('Image uploaded successfully.');
        } catch (e) {
          print('Failed to upload image: $e');
          _showSnackBar('Failed to upload image: $e');
        }
      } else {
        print('No image selected.');
      }
    } else {
      _showSnackBar('Camera and storage permissions are required.');
    }
  }

  Future<String> _uploadImageToFirebase(XFile pickedFile) async {
    String fileName = path.basename(pickedFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('user-emergencies/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(File(pickedFile.path));
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> reportEmergency(String emergencyType, Position position) async {
    await _firestore.collection('emergencies').add({
      'type': emergencyType,
      'latitude': position.latitude,
      'longitude': position.longitude,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
