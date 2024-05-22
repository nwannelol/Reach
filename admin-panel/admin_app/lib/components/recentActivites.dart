import 'package:admin_app/config/size_config.dart';
import 'package:admin_app/style/colors.dart';
import 'package:admin_app/style/styles.dart';
import 'package:flutter/material.dart';

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
            PrimaryText(text: 'Recent Activity', size: 18, fontWeight: FontWeight.w800,)
          ],
        )
      ],
    );
  }
}
