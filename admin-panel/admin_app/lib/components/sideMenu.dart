import 'package:admin_app/config/size_config.dart';
import 'package:admin_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1.5, // I wrapped my container with a center and changed it to 'Drawer' to really denmarcate it. Also added elevation for style
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        color: AdminAppColors.secondaryBg,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
            Container(
              height: 100,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 35,
                height: 35,
                child: SvgPicture.asset('assets/mac-action.svg'),),
            ),
            
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/home.svg',
                width: 30, // Specify the desired width
                height: 30, // Specify the desired height
              ),
              color: AdminAppColors.iconGray,
              padding: EdgeInsets.symmetric(vertical: 25.0),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/pie-chart.svg',
                width: 30,
                height: 30,
              ),
              color: AdminAppColors.iconGray,
              padding: EdgeInsets.symmetric(vertical: 25.0),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/calendar.svg',
                width: 30,
                height: 30,
              ),
              color: AdminAppColors.iconGray,
              padding: EdgeInsets.symmetric(vertical: 25.0),
            ),
            ],),
            ),
      ),
    );
  }
}