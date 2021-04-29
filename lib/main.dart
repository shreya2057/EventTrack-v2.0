import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:get/route_manager.dart';

import './routes.dart';
import './services/authState.dart';
import 'screens/event/create_form/main_form.dart';
import 'screens/home/homeinit.dart';

Future main() async {
  await DotEnv.load(fileName: ".env");
  runApp(EventTrack());
}

class EventTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'EventTrack',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthState.readAuthState(),
        builder: (context, snap) {
          if (!snap.hasData) {
            return CircularProgressIndicator();
          } else {
            if (!snap.data['isAuthenticated']) {
              return CreateEventForm();
              // return EventExtraInput();
              // return Welcome();
            } else {
              return HomeInit();
            }
          }
        },
      ),
      getPages: Routes.routes,
    );
  }
}
