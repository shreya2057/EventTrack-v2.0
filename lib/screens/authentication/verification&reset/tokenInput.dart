import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/background.dart';
import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../connect_server/auth.dart';
import '../../../routes.dart';
import '../../../services/authState.dart';
import '../../../theme/extension.dart';
import '../../../theme/light_color.dart';
import '../../../theme/text_styles.dart';

class TokenInput extends StatelessWidget {
  final RxString _token = ''.obs;
  final Map _arguments = Get.arguments;
  final RxBool _isAuthenticating = false.obs;

  void sendToken() async {
    await AuthServer.sendToken(_arguments['email']).then((res) {
      if (!res.status) {
        FlashMessage.errorFlash(res.message);
      } else {
        FlashMessage.successFlash(res.message);
      }
    });
  }

  validation() {
    if (_token.value.length != 4) {
      FlashMessage.errorFlash('The token is 4-digit.');
      return false;
    }
    return true;
  }

  verifyEmail(BuildContext context) async {
    if (validation()) {
      await AuthServer.verifyEmail(_token.value, _arguments['email'])
          .then((res) async {
        print(res.status);
        if (!res.status) {
          FlashMessage.errorFlash(res.message);
        } else {
          await AuthState.setAuthState(res.user.id);

          FlashMessage.successFlash(res.message);
          Get.offAllNamed(Routes.homeInit);
        }
      });
    }
  }

  verifyToken(BuildContext context) async {
    if (validation()) {
      await AuthServer.verifyToken(_token.value, _arguments['email'])
          .then((res) {
        if (!res.status) {
          FlashMessage.errorFlash(res.message);
        } else {
          FlashMessage.successFlash(res.message);
          Get.offNamed(
            Routes.passwordInput,
            arguments: _arguments['email'],
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = _arguments['isEmailVerification']
        ? 'Verify Your Email'
        : 'Verify Your Token';
    final String body = _arguments['isEmailVerification']
        ? 'You must verify your email to proceed forward.\n'
        : '' +
            'You will receive a token in your email. Type your token here to verify your token.';

    return Scaffold(
      body: Background(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyles.h1Style,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              body,
              style: TextStyles.body.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ).hP16,
            TextButton(
              onPressed: sendToken,
              child: Text(
                'Get a Token',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: FontSizes.body,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Obx(
              () => Column(
                children: [
                  RoundedInputField(
                    controller: _token,
                    hintText: 'Enter Your Token',
                    textAlign: TextAlign.center,
                    width: 0.5,
                  ),
                  !_isAuthenticating.value
                      ? RoundedButton(
                          text: 'Verify',
                          onPress: () {
                            _isAuthenticating.value = true;
                            FocusScope.of(context).unfocus();

                            _arguments['isEmailVerification']
                                ? verifyEmail(context)
                                : verifyToken(context);
                            _isAuthenticating.value = false;
                          },
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                Get.toNamed(Routes.login);
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
    );
  }
}
