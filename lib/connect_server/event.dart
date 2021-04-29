import '../services/response.dart';

class EventServer {
  EventServer._();

  static create(data) {
    return HttpServer().postRequest(
      '/e/create',
      data: data,
    );
  }
}
