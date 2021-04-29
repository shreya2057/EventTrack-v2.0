import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/rounded_button.dart';
import '../../../model/event.dart';
import '../../../picker/filepicker.dart';
import '../../../picker/locationpicker.dart';
import '../../../states/events.dart';
import '../../../theme/extension.dart';
import '../../../theme/text_styles.dart';

class EventExtraInput extends StatefulWidget {
  @override
  _EventExtraInputState createState() => _EventExtraInputState();
}

class _EventExtraInputState extends State<EventExtraInput> {
  LocationModel _pickedLocation;
  File _cover;
  void _pickedImage(File image) {
    _cover = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Upload a Cover for the Event',
              style: TextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
            ),
            PickaFile(_pickedImage).vP16,
            SizedBox(
              height: 20,
            ),
            Text(
              'Pick the location of your Event',
              style: TextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await Get.to(() => PickALocation());
                setState(() {
                  _pickedLocation = result;
                });
              },
              child: Text('Pick a Location'),
            ),
            if (_pickedLocation != null)
              Text(_pickedLocation.toMap().toString()),
            RoundedButton(
              text: "Next",
              onPress: () {
                FocusScope.of(context).unfocus();

                final newEvent = EventModel(
                  eventCover: _cover,
                  location: _pickedLocation,
                );

                // if (validation()) {
                // EventServer.eventform(newEvent.toMap()).then((res) async {
                //   if (!res.status) {
                //     FlashMessage.errorFlash(res.message);
                //   } else {
                Event.to.loadEvent(newEvent, phase: 'second');
                // Get.offNamed(
                //   Routes.eventExtraInput,
                //   // arguments: newEvent,
                // );
                Event.to.createEvent();
                // }
                // });
                // }
              },
            ),
          ],
        ).vP8,
      ),
    );
  }
}
