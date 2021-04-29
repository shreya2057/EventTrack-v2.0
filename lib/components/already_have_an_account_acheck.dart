import 'package:flutter/material.dart';
import '../theme/light_color.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function onPress;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: LightColor.lightBlue),
        ),
        GestureDetector(
          onTap: onPress,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: LightColor.lightBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
