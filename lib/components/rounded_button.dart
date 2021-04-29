import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/extension.dart';
import '../theme/light_color.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    @required this.text,
    @required this.onPress,
    this.color = LightColor.skyBlue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: Get.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: TextButton(
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
          onPressed: onPress,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ).ps(y: 12),
        ),
      ),
    );
  }
}
