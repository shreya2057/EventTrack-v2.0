import 'event.dart';
import 'user.dart';

class ResponseModel {
  final String message;
  final bool status;
  final UserModel user;
  final EventModel event;

  ResponseModel({
    this.message = '',
    this.status = false,
    this.user,
    this.event,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      message: map['message'],
      status: map['status'] ?? false,
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
    );
  }
}
