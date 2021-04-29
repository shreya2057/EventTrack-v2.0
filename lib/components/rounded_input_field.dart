import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/light_color.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon, suffixIcon;
  final bool autofocus;
  final bool obscureText;
  final Function(String) controller;
  final Function onClickedSuffixIcon;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final TextAlign textAlign;
  final double width;

  const RoundedInputField({
    Key key,
    @required this.controller,
    this.icon,
    this.hintText = '',
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.width = 0.8,
    this.capitalization = TextCapitalization.none,
    this.onClickedSuffixIcon,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextFormField(
        key: key,
        onChanged: controller,
        autofocus: autofocus,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textCapitalization: capitalization,
        cursorColor: LightColor.lightBlue,
        textAlign: textAlign,
        decoration: InputDecoration(
          hintText: hintText,
          icon: icon != null
              ? Icon(
                  icon,
                  color: LightColor.lightBlue,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  icon: Icon(
                    suffixIcon,
                    color: LightColor.lightBlue,
                  ),
                  onPressed: onClickedSuffixIcon,
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final double width;
  const TextFieldContainer({
    Key key,
    this.child,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: Get.width * width,
      decoration: BoxDecoration(
        color: LightColor.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: child,
    );
  }
}
