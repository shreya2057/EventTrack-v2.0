import 'event.dart';
import 'user.dart';

class ResponseModel {
  String message;
  bool status;
  String value;
  UserModel user;
  EventModel event;

  ResponseModel({
    this.message = '',
    this.status = false,
    this.value,
    this.user,
    this.event,
  });

  factory ResponseModel.fromMap(Map<String, dynamic> map) {
    return ResponseModel(
      message: map['message'],
      status: map['status'] ?? false,
      value: map['value'] ?? '',
      user: map['user'] != null ? UserModel.fromMap(map['user']) : null,
      event: map['event'] != null ? EventModel.fromMap(map['event']) : null,
    );
  }
}
