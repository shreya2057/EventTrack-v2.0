import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/message.dart';
import '../../components/rounded_button.dart';
import '../../routes.dart';
import '../../services/authState.dart';
import '../../states/user.dart';
import '../../theme/extension.dart';
import '../../theme/text_styles.dart';
import '../../theme/theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xffffffff), width: 5, style: BorderStyle.solid),
              boxShadow: AppTheme.shadow,
              borderRadius: BorderRadius.all(
                Radius.circular(Get.width * 0.30),
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage:
                  NetworkImage(User.to.currentUser.value.profileUrl),
              radius: Get.width * .10,
            ),
          ).p16,
          Text(
            'Welcome ${User.to.currentUser.value.name}',
            style: TextStyles.titleNormal,
          ),
          RoundedButton(
            text: 'Logout',
            onPress: () async {
              await AuthState.removeAuthState().then((val) =>
                  FlashMessage.successFlash('Successfully Logged out.'));
              Get.offAllNamed(Routes.login);
            },
          )
        ],
      ).alignCenter,
    );
  }
}
