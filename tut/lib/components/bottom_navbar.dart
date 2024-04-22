import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 50,
      color: Color.fromARGB(255, 251, 251, 251),
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisSize: MainAxisSize.min, // Center the icons vertically
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Color.fromRGBO(226, 48, 71, 1)),
            onPressed: () {},
          ),
          SizedBox(), // This SizedBox creates the notch for the FloatingActionButton
          IconButton(
            icon: Icon(Icons.access_time, color: Color.fromRGBO(226, 48, 71, 1)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class FloatingActionButtonWidget extends StatelessWidget {
  const FloatingActionButtonWidget({Key? key}) : super(key: key);

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
                    leading: Icon(Icons.lock),
                    title: Text('Harassment'),
                    onTap: () {
                      // Handle Fire action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.local_police),
                    title: Text('Police'),
                    onTap: () {
                      // Handle Police action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.notification_important),
                    title: Text('Siren'),
                    onTap: () {
                      // Handle Siren action
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(226, 48, 71, 1),
      mini: true,
      shape: CircleBorder(),
    );
  }
}
