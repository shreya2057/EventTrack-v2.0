import '../services/response.dart';

class AuthServer {
  AuthServer._();

  static signup(Map<String, dynamic> data) {
    return HttpServer().postRequest(
      '/signup',
      data: data,
    );
  }

  static login(Map<String, dynamic> data) {
    return HttpServer().postRequest(
      '/login',
      data: data,
    );
  }

  static sendToken(String email) {
    return HttpServer().postRequest(
      '/sendToken',
      data: {'email': email},
    );
  }

  static verifyEmail(String token, String email) {
    return HttpServer().getRequest(
      '/verify',
      data: {'email': email, 'token': token},
    );
  }

  static verifyToken(String token, String email) {
    return HttpServer().getRequest(
      '/resetPassword',
      data: {'email': email, 'token': token},
    );
  }

  static resetPassword(String email, String password) {
    return HttpServer().postRequest(
      '/resetPassword',
      data: {'email': email, 'password': password},
    );
  }
}
