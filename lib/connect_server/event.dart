import '../services/response.dart';

class EventServer {
  EventServer._();

  static eventform(Map<String, dynamic> data) {
    return HttpServer().postRequest(
      '/e/eventform',
      data: data,
    );
  }
}
