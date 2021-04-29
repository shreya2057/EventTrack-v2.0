import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/extension.dart';
import '../theme/light_color.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.02),
      width: Get.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Text(
            "OR",
            style: TextStyle(
              color: LightColor.skyBlue,
              fontWeight: FontWeight.w600,
            ),
          ).ps(x: 10),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}
