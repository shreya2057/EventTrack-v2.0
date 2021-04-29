import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/background.dart';
import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../connect_server/auth.dart';
import '../../../routes.dart';
import '../../../services/authState.dart';
import '../../../theme/light_color.dart';
import '../../../theme/text_styles.dart';

class Login extends StatelessWidget {
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;

  final RxBool obscurePassword = true.obs;
  final RxBool _isAuthenticating = false.obs;

  validation() {
    if (_email.value.trim().isEmpty || _password.value.isEmpty) {
      FlashMessage.errorFlash('You have an empty field.');
    } else if (!_email.value.contains('@')) {
      FlashMessage.errorFlash('Invalid Email.');
    } else if (_password.value.length < 8) {
      FlashMessage.errorFlash('Invalid Password.');
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyles.h1Style,
              ),
              SizedBox(height: Get.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: Get.height * 0.35,
              ),
              SizedBox(height: Get.height * 0.03),
              Obx(
                () => Column(
                  children: [
                    RoundedInputField(
                      hintText: "Email",
                      icon: Icons.person,
                      autofocus: true,
                      controller: _email,
                    ),
                    RoundedInputField(
                      hintText: 'Password',
                      icon: Icons.lock,
                      obscureText: obscurePassword.value,
                      suffixIcon: !obscurePassword.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      onClickedSuffixIcon: () {
                        obscurePassword.value = !obscurePassword.value;
                      },
                      controller: _password,
                    ),
                    !_isAuthenticating.value
                        ? RoundedButton(
                            text: "LOGIN",
                            onPress: () async {
                              _isAuthenticating.value = true;
                              FocusScope.of(context).unfocus();

                              final user = {
                                'email': _email.value.trim(),
                                'password': _password.value,
                              };
                              if (validation()) {
                                await AuthServer.login(user).then((res) async {
                                  if (!res.status) {
                                    FlashMessage.errorFlash(res.message);
                                  } else {
                                    await AuthState.setAuthState(res.user.id);
                                    Get.offAllNamed(Routes.homeInit);
                                  }
                                });
                              }
                              _isAuthenticating.value = false;
                            },
                          )
                        : CircularProgressIndicator(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forgot Your Password?',
                    style: TextStyles.bodySm,
                  ),
                  TextButton(
                    onPressed: () {
                      if (_email.value.trim().isEmpty) {
                        FlashMessage.errorFlash(
                            'Please write your email first.');
                      } else {
                        Get.toNamed(
                          Routes.tokenInput,
                          arguments: {
                            'email': _email.value.trim(),
                            'isEmailVerification': false
                          },
                        );
                      }
                    },
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                        color: LightColor.lightBlue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.03),
              AlreadyHaveAnAccountCheck(
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
