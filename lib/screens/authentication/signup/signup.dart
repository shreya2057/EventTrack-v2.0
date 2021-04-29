import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/background.dart';
import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../connect_server/auth.dart';
import '../../../routes.dart';
import '../../../theme/text_styles.dart';

class Signup extends StatelessWidget {
  final RxString _name = ''.obs;
  final RxString _email = ''.obs;
  final RxString _password = ''.obs;
  final RxString _phone = ''.obs;

  final RxBool obscurePassword = true.obs;
  final RxBool _isAuthenticating = false.obs;

  validation() {
    if (_name.value.trim().isEmpty ||
        _email.value.trim().isEmpty ||
        _password.value.isEmpty ||
        _phone.value.trim().isEmpty) {
      FlashMessage.errorFlash('You have an empty field.');
    } else if (_password.value.length < 8) {
      FlashMessage.errorFlash('Password must be at least 8 characters long.');
    } else if (_phone.value.trim().length != 10) {
      FlashMessage.errorFlash('Invalid Phone Number.');
    } else if (!_email.value.contains('@')) {
      FlashMessage.errorFlash('Invalid Email.');
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
          child: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign Up",
                  style: TextStyles.h1Style,
                ),
                SizedBox(height: Get.height * 0.03),
                RoundedInputField(
                  hintText: "Full Name",
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  capitalization: TextCapitalization.words,
                  autofocus: true,
                  controller: _name,
                ),
                RoundedInputField(
                    hintText: "Email",
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: _email),
                RoundedInputField(
                  hintText: 'Password',
                  icon: Icons.lock,
                  controller: _password,
                  obscureText: obscurePassword.value,
                  suffixIcon: !obscurePassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onClickedSuffixIcon: () {
                    obscurePassword.value = !obscurePassword.value;
                  },
                ),
                RoundedInputField(
                  hintText: "Phone Number",
                  icon: Icons.phone,
                  controller: _phone,
                  keyboardType: TextInputType.number,
                ),
                !_isAuthenticating.value
                    ? RoundedButton(
                        text: "SIGNUP",
                        onPress: () async {
                          _isAuthenticating.value = true;
                          FocusScope.of(context).unfocus();

                          final newUser = {
                            'name': _name.value.trim(),
                            'email': _email.value.trim(),
                            'password': _password.value,
                            'phone': _phone.value.trim(),
                          };
                          if (validation()) {
                            await AuthServer.signup(newUser).then((res) async {
                              if (!res.status) {
                                FlashMessage.errorFlash(res.message);
                              } else {
                                Get.offNamed(Routes.tokenInput, arguments: {
                                  'email': newUser['email'],
                                  'isEmailVerification': true,
                                });
                              }
                            });
                          }
                          _isAuthenticating.value = false;
                        },
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: Get.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  onPress: () {
                    Get.toNamed(Routes.login);
                  },
                ),
                // OrDivider(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     SocialIcon(
                //       iconSrc: "assets/icons/facebook.svg",
                //       press: () {},
                //     ),
                //     SocialIcon(
                //       iconSrc: "assets/icons/google-plus.svg",
                //       press: () {},
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
