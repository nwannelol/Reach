import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class reportFloatingActionButton extends StatelessWidget {
  const reportFloatingActionButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Harassment'),
                    onTap: () async {
                      Navigator.pop(context); // Close the bottom sheet

                      // Check and request location permissions
                      LocationPermission permission = await Geolocator.checkPermission();
                      if (permission == LocationPermission.denied) {
                        permission = await Geolocator.requestPermission();
                        if (permission == LocationPermission.denied) {
                          // Permissions are denied, handle appropriately.
                          return;
                        }
                      }

                      if (permission == LocationPermission.deniedForever) {
                        // Permissions are denied forever, handle appropriately.
                        return;
                      }

                      Position? position;
                      try {
                        // Increase the time limit to 20 seconds
                        final locationStream = Geolocator.getPositionStream(
                          locationSettings: const LocationSettings(
                            accuracy: LocationAccuracy.high,
                            distanceFilter: 0, // Update for any movement
                            timeLimit: Duration(seconds: 20),
                          ),
                        );

                        await for (Position pos in locationStream) {
                          position = pos;
                          break; // Take the first position update and stop listening
                        }
                      } on TimeoutException catch (e) {
                        print('TimeoutException: ${e.message}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to get location: Timeout'))
                        );
                        return;
                      } catch (e) {
                        print('An unexpected error occurred: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to get location: $e'))
                        );
                        return;
                      }

                      if (position != null) {
                        // Show the location in a SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Current location: Lat: ${position.latitude}, Lon: ${position.longitude}'))
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully reported emergency. Please await official response.'))
                        );
                        // Store the location in a variable
                        double latitude = position.latitude;
                        double longitude = position.longitude;

                        // Send the location to your database
                        // Example:
                        // await sendLocationToDatabase(latitude, longitude);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_police),
                    title: const Text('Security'),
                    onTap: () {
                      Navigator.pop(context); // Close the bottom sheet
                      // Handle Security action
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notification_important),
                    title: const Text('Fire'),
                    onTap: () {
                      Navigator.pop(context); // Close the bottom sheet
                      // Handle Fire action
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      backgroundColor: const Color.fromRGBO(226, 48, 71, 1),
      mini: true,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}