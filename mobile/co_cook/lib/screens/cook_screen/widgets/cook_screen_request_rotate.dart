import 'package:co_cook/styles/colors.dart';
import 'package:co_cook/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:co_cook/utils/route.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:co_cook/screens/cook_screen/cook_screen.dart';

class CookScreenRequestRotate extends StatelessWidget {
  const CookScreenRequestRotate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CustomColors.redPrimary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 124,
              margin: EdgeInsets.only(bottom: 24.0),
              child: Image.asset('assets/images/etc/rotate_phone_request.gif')),
          SizedBox(
              child: Text(
            "화면을 가로로 돌려주세요",
            style: CustomTextStyles()
                .subtitle1
                .copyWith(color: CustomColors.monotoneLight),
          ))
        ],
      ),
    );
  }
}
