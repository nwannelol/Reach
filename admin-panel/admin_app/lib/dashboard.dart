import 'package:admin_app/components/heroButtons.dart';
import 'package:admin_app/components/recentActivites.dart';
import 'package:admin_app/components/sideMenu.dart';
import 'package:admin_app/config/size_config.dart';
import 'package:admin_app/data.dart';
import 'package:admin_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  RecentActivities()
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}

