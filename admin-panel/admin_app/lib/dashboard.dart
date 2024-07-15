import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin_app/components/heroButtons.dart';
import 'package:admin_app/components/recentActivites.dart';
import 'package:admin_app/components/sideMenu.dart';
import 'package:admin_app/config/size_config.dart';
import 'package:admin_app/data.dart';
import 'package:admin_app/style/colors.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SideBar(),
            ),
            Expanded(
              flex: 10,
              child: Container(
                width: double.infinity,
                height: SizeConfig.screenHeight,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('user-locations').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data!.docs;
                    return DataTable(
                      columns: [
                        DataColumn(label: Text('UserId')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Emergency Type')),
                        DataColumn(label: Text('Location')),
                        DataColumn(label: Text('Time')),
                        DataColumn(label: Text('Email')),
                        // Add more columns as needed
                      ],
                      rows: data.map((doc) {
                        return DataRow(cells: [
                          DataCell(Text(doc['field1'].toString())),
                          DataCell(Text(doc['field2'].toString())),
                          // Add more cells as needed
                        ]);
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                height: SizeConfig.screenHeight,
                color: AdminAppColors.secondaryBg,
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  children: [
                    HeroButtons(),
                    // RecentActivities()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
