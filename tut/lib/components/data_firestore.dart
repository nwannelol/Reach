import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> reportEmergency(String emergencyType, Position position) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userId = user.uid;

    final locationDoc = {
      'emergencyType': emergencyType,
      'useruid': userId,
      'email': user.email,
      'location': GeoPoint(position.latitude, position.longitude),
      'timestamp': Timestamp.now(),
      'accuracy': position.accuracy,
    };

    await _firestore.collection('user-locations').add(locationDoc);
  }
}
