import 'package:admin_app/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeroButtons extends StatelessWidget {
  const HeroButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {}, 
          icon: SvgPicture.asset(
            'assers/ring.svg', width: 20,)
            ),
    
        SizedBox(width: 10,),
    
        IconButton(
          onPressed: () {}, 
          icon: SvgPicture.asset(
            'assets/ring.svg', width: 20,)
            ),
    
        SizedBox(width: 10,),
    
        IconButton(
          onPressed: () {}, 
          icon: SvgPicture.asset(
            'assets/calendar.svg', width: 20,)
            ),
    
        SizedBox(width: 15,),
        
        Row(
          children: [
            CircleAvatar(
              radius: 17,
              backgroundImage: NetworkImage(''),
            ),
            Icon(Icons.arrow_drop_down_outlined, color:  AdminAppColors.black)
          ],
        )
      ],
    );
  }
}


