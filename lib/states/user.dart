import 'package:get/get.dart';

import '../components/message.dart';
import '../connect_server/user.dart';
import '../model/user.dart';
import '../routes.dart';
import '../services/authState.dart';

class User extends GetxController {
  static User get to => Get.find();
  Rx<UserModel> currentUser = UserModel().obs;

  @override
  void onInit() {
    AuthState.readAuthState().then((state) {
      getCurrentUser(state['userId']).then((user) {
        if (user.isEmailVerified) {
          currentUser.value = user;
          update();
        } else {
          AuthState.removeAuthState().then((_) {
            Get.offNamed(Routes.tokenInput,
                arguments: {'email': user.email, 'isEmailVerification': true});
          });
        }
      });
    });
    super.onInit();
  }

  getCurrentUser(String id) async {
    return await UserServer.getCurrentUser(id).then((res) async {
      if (!res.status) {
        FlashMessage.errorFlash(res.message);
        await AuthState.removeAuthState();
        Get.offAllNamed(Routes.login);
      } else {
        return res.user;
      }
    });
  }
}
