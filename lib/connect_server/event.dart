import '../services/response.dart';

class EventServer {
  EventServer._();

  static create(data) {
    return HttpServer().postRequest(
      '/e/create',
      data: data,
    );
  }

  static uploadCover(data) {
    return HttpServer().postRequest(
      '/e/upload-cover',
      data: data,
    );
  }
}
