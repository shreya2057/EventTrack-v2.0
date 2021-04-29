import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/text_styles.dart';

class FlashMessage {
  FlashMessage._();

  static successFlash(String message) {
    return Get.snackbar(
      '',
      '',
      titleText: Text(
        'Success',
        textAlign: TextAlign.center,
        style: TextStyles.titleM.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyles.body.copyWith(
          color: Colors.white,
          letterSpacing: 0.2,
        ),
      ),
      isDismissible: false,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.greenAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.all(0),
    );
  }

  static errorFlash(String message) {
    return Get.snackbar(
      '',
      '',
      titleText: Text(
        'Error',
        textAlign: TextAlign.center,
        style: TextStyles.titleM.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.3,
        ),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyles.body.copyWith(
          color: Colors.white,
          letterSpacing: 0.2,
        ),
      ),
      isDismissible: false,
      duration: Duration(seconds: 3),
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.GROUNDED,
      margin: EdgeInsets.all(0),
    );
  }
}
