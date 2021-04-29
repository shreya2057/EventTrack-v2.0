import '../services/response.dart';

class UserServer {
  UserServer._();

  static getCurrentUser(String id) async {
    return await HttpServer().getRequest(
      '/u',
      data: {'id': id},
    );
  }
}
