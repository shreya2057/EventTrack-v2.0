import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../model/event.dart';
import '../../../picker/datetimepicker.dart';
import '../../../picker/locationpicker.dart';
import '../../../routes.dart';
import '../../../states/events.dart';
import '../../../theme/extension.dart';
import '../../../theme/text_styles.dart';

class EventExtraInput extends StatelessWidget {
  final _pickedLocation = Rx<LocationModel>();
  final RxBool _isOneDayEvent = true.obs;
  final _pickedDate = Rx<List<String>>([]);
  final _pickedTime = Rx<List<TimeOfDay>>([]);
  final TextStyle style =
      TextStyles.titleNormal.copyWith(fontWeight: FontWeight.w400);
  final RxBool _isUploading = false.obs;

  void toggleSwitch(bool value) {
    _isOneDayEvent.value = value;
  }

  bool validation() {
    if (_pickedLocation.value == null) {
      FlashMessage.errorFlash('Location for your event is still unknown.');
    } else if ((_pickedDate.value.length == 0) ||
        (_pickedDate.value.length <= 1 && !_isOneDayEvent.value)) {
      FlashMessage.errorFlash('Date for your event is still unknown.');
    } else if (_pickedTime.value.length != 2) {
      FlashMessage.errorFlash('Time for your event is still unknown.');
    } else {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Text(
                      'Date & Time',
                      style: TextStyles.titleM
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'One day Event',
                          style: style,
                        ).hP8,
                        Switch(
                            value: _isOneDayEvent.value,
                            onChanged: toggleSwitch),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  _pickedDate.value = _isOneDayEvent.value
                                      ? await DateTimePicker.datePicker(context)
                                      : await DateTimePicker.dateRangePicker(
                                          context);
                                },
                                icon: Icon(Icons.calendar_today),
                                label: Flexible(
                                  child: Text(
                                    'Pick the date',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Text(
                                _pickedDate.value.length != 0
                                    ? _pickedDate.value.length == 1
                                        ? 'Event Date: ' +
                                            _pickedDate.value.formatDate[0]
                                        : 'From: ' +
                                            _pickedDate.value.formatDate[0] +
                                            '\nTo: ' +
                                            _pickedDate.value.formatDate[1]
                                    : '',
                                textAlign: TextAlign.center,
                                style: style,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  _pickedTime.value =
                                      await DateTimePicker.timePicker(context);
                                },
                                icon: Icon(Icons.access_time),
                                label: Flexible(
                                  child: Text(
                                    'Pick the start and end time',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              if (_pickedTime.value.length != 0)
                                Text(
                                  'From: ' +
                                      _pickedTime.value.formatTime(context)[0] +
                                      '\nTo: ' +
                                      _pickedTime.value.formatTime(context)[1],
                                  style: style,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ).hP8,
                  ],
                ),
              ),
              Divider(
                thickness: 1.3,
              ).hP16,
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      'Pick the location of your Event',
                      style: TextStyles.titleM
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        var result = await Get.to(() => PickALocation());
                        _pickedLocation.value = result;
                      },
                      icon: Icon(Icons.location_pin),
                      label: Text('Pick a Location'),
                    ),
                    if (_pickedLocation.value != null)
                      Text(
                        _pickedLocation.value.toMap().toString(),
                        style: style,
                      ).hP8,
                  ],
                ),
              ),
              !_isUploading.value
                  ? RoundedButton(
                      text: "Next",
                      onPress: () {
                        _isUploading.value = true;
                        FocusScope.of(context).unfocus();
                        final newEvent = EventModel(
                          date: _pickedDate.value,
                          time: _pickedTime.value.formatTime(context),
                          location: _pickedLocation.value,
                        );
                        if (validation()) {
                          Event.to.loadEvent(newEvent, 'extra');
                          Event.to.createEvent().then((res) async {
                            if (!res.status) {
                              FlashMessage.errorFlash(res.message);
                              Get.back();
                            } else {
                              Event.to
                                  .loadEvent(EventModel(id: res.value), 'id');
                              Get.offNamed(Routes.uploadCover);
                            }
                          });
                        }
                        _isUploading.value = false;
                      },
                    )
                  : CircularProgressIndicator(),
            ],
          ).vP8,
        ),
      ),
    );
  }
}
