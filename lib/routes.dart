import 'package:get/route_manager.dart';

import 'screens/Welcome/welcome.dart';
import 'screens/authentication/login/login.dart';
import 'screens/authentication/signup/signup.dart';
import 'screens/authentication/verification&reset/passwordInput.dart';
import 'screens/authentication/verification&reset/tokenInput.dart';
import 'screens/event/create_form/extra_form.dart';
import 'screens/event/create_form/main_form.dart';
import 'screens/event/create_form/upload_cover.dart';
import 'screens/event/detail/event_main.dart';
import 'screens/home/home.dart';
import 'screens/home/homeinit.dart';

class Routes {
  Routes._();

  // Routes initialization
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String tokenInput = '/tokenInput';
  static const String passwordInput = '/passwordInput';
  static const String homeInit = '/homeInit';
  static const String homepage = '/homepage';
  static const String eventform = '/eventform';
  static const String eventExtraInput = '/eventExtraInput';
  static const String uploadCover = '/eventCoverUpload';
  static const String eventdetails = '/eventdetails';

  // Setting the routes
  static final routes = <GetPage>[
    GetPage(name: welcome, page: () => Welcome()),
    GetPage(name: login, page: () => Login()),
    GetPage(name: signup, page: () => Signup()),
    GetPage(name: tokenInput, page: () => TokenInput()),
    GetPage(name: passwordInput, page: () => PasswordInput()),
    GetPage(name: homeInit, page: () => HomeInit()),
    GetPage(name: homepage, page: () => HomePage()),
    GetPage(name: eventdetails, page: () => EventDetailMain()),
    GetPage(name: eventform, page: () => CreateEventForm()),
    GetPage(name: eventExtraInput, page: () => EventExtraInput()),
    GetPage(name: uploadCover, page: () => UploadEventCover()),
  ];
}
