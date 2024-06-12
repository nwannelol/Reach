import 'package:admin_app/config/size_config.dart';
import 'package:admin_app/style/colors.dart';
import 'package:admin_app/style/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RecentActivities extends StatelessWidget {
  const RecentActivities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 5,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: AdminAppColors.iconGray,
                    blurRadius: 15,
                    offset: const Offset(10, 15)),
              ]),
        ),
        SizedBox(
          height: SizeConfig.blockSizeHorizontal! * 5,
        ),

        Column(
          children: [
            PrimaryText(text: 'Recent Activity', size: 18, fontWeight: FontWeight.w800,),
            //PrimaryText()

          ],
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical! * 2,
        ),

        ListTile(
          contentPadding: EdgeInsets.only(left: 0, right: 20),
          visualDensity: VisualDensity.standard,
          leading: Container(
            width: 50,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            decoration: BoxDecoration(
              color: AdminAppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset('assets/water', width: 20,),

          ),
          title: PrimaryText(text: 'water bill', fontWeight: FontWeight.w500,),
          subtitle: Row(
            
          ),
        )
      ],
    );
  }
}
