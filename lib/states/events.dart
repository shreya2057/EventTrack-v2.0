import 'dart:io';

import 'package:get/get.dart';

import '../connect_server/event.dart';
import '../model/event.dart';

class Event extends GetxController {
  static Event get to => Get.find();

  Rx<EventModel> event = EventModel().obs;

  loadEvent(EventModel e, [String phase = 'main']) {
    switch (phase) {
      case 'main':
        event.value.title = e.title;
        event.value.description = e.description;
        event.value.categories = e.categories;
        // event.value.author = User.to.currentUser.value.id;
        break;
      case 'extra':
        event.value.location = e.location;
        event.value.date = e.date;
        event.value.time = e.time;
        break;
      case 'cover':
        event.value.eventCover = e.eventCover;
        break;
      case 'coverUrl':
        event.value.eventCoverUrl = e.eventCoverUrl;
        break;
      case 'id':
        event.value.id = e.id;
        break;
      default:
        break;
    }

    update();
  }

  createEvent() async {
    return await EventServer.create(event.value.toMap());
  }

  uploadCover(File cover) async {
    FormData data = FormData({
      'id': event.value.id,
      'eventCover': MultipartFile(
        event.value.eventCover,
        filename: event.value.eventCover.path.split('/').last,
      )
    });
    return await EventServer.uploadCover(data);
  }
}
