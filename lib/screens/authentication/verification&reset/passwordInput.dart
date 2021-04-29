import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/background.dart';
import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../connect_server/auth.dart';
import '../../../routes.dart';
import '../../../services/authState.dart';
import '../../../theme/light_color.dart';
import '../../../theme/text_styles.dart';

class PasswordInput extends StatelessWidget {
  final RxString _password = ''.obs;
  final RxString _retypedPassword = ''.obs;
  final RxBool obscurePassword = true.obs,
      obscureRetyped = true.obs,
      _isAuthenticating = false.obs;
  final String _email = Get.arguments;

  validation() {
    if (_password.value.length < 8 || _retypedPassword.value.length < 8) {
      FlashMessage.errorFlash('Your password must be at least 8 characters.');
    } else if (_password.value != _retypedPassword.value) {
      FlashMessage.errorFlash('Your Passwords do not match');
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Set Your New Password',
                style: TextStyles.h1Style,
              ),
              SizedBox(
                height: 50,
              ),
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
                hintText: 'Confirm Password',
                icon: Icons.lock,
                controller: _retypedPassword,
                obscureText: obscureRetyped.value,
                suffixIcon: !obscureRetyped.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                onClickedSuffixIcon: () {
                  obscureRetyped.value = !obscureRetyped.value;
                },
              ),
              !_isAuthenticating.value
                  ? RoundedButton(
                      text: "Change Password",
                      onPress: () async {
                        _isAuthenticating.value = true;
                        FocusScope.of(context).unfocus();
                        if (validation()) {
                          await AuthServer.resetPassword(
                                  _email, _password.value)
                              .then((res) async {
                            if (!res.status) {
                              FlashMessage.errorFlash(res.message);
                            } else {
                              FlashMessage.successFlash(
                                  'Your password has been changed.');
                              await AuthState.setAuthState(res.user.id);
                              Get.offAllNamed(Routes.homeInit);
                            }
                          });
                        }
                        _isAuthenticating.value = false;
                      },
                    )
                  : CircularProgressIndicator(),
              OutlinedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Get.back();
                },
                child: Text('Cancel'),
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    BorderSide(
                      color: LightColor.skyBlue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
