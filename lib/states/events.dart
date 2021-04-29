import 'package:get/get.dart';

import '../connect_server/event.dart';
import '../model/event.dart';

class Event extends GetxController {
  static Event get to => Get.find();

  Rx<EventModel> event = EventModel().obs;

  loadEvent(EventModel e, {String phase = 'first'}) {
    switch (phase) {
      case 'first':
        event.value.title = e.title;
        event.value.description = e.description;
        event.value.categories = e.categories;
        // event.value.author = User.to.currentUser.value.id;
        break;
      case 'second':
        event.value.eventCover = e.eventCover;
        event.value.location = e.location;
        break;
      default:
        break;
    }

    update();
  }

  createEvent() async {
    FormData data = FormData({
      ...event.value.toMap(),
      'eventCover': MultipartFile(
        event.value.eventCover,
        filename: event.value.eventCover.path.split('/').last,
      )
    });
    return await EventServer.create(data);
  }
}
