import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../components/background.dart';
import '../../components/rounded_button.dart';
import '../../routes.dart';
import '../../theme/light_color.dart';
import '../../theme/text_styles.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO EVENTTRACK",
                style: TextStyles.h1Style,
              ),
              SizedBox(height: Get.width * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: Get.width * 0.45,
              ),
              SizedBox(height: Get.width * 0.05),
              RoundedButton(
                text: "LOGIN",
                onPress: () {
                  Get.toNamed(Routes.login);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: LightColor.extraLightBlue,
                textColor: LightColor.lightBlack,
                onPress: () {
                  Get.toNamed(Routes.signup);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
