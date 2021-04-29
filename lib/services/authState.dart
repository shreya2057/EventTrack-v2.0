import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  AuthState._();

  static setAuthState(String id) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userId', id);
    _prefs.setBool('isAuthenticated', true);
    return;
  }

  static readAuthState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var authState = {
      'userId': _prefs.getString('userId'),
      'isAuthenticated': _prefs.containsKey('isAuthenticated')
          ? _prefs.getBool('isAuthenticated')
          : false,
    };
    return authState;
  }

  static removeAuthState() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove('userId');
    _prefs.remove('isAuthenticated');
  }
}
