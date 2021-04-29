import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/event.dart';
import '../../../picker/filepicker.dart';
import '../../../picker/locationpicker.dart';
import '../../../theme/extension.dart';
import '../../../theme/text_styles.dart';

class EventExtraInput extends StatefulWidget {
  @override
  _EventExtraInputState createState() => _EventExtraInputState();
}

class _EventExtraInputState extends State<EventExtraInput> {
  File _cover;
  LocationModel _pickedLocation;
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
                var result = await Get.to(PickALocation());
                setState(() {
                  _pickedLocation = result;
                });
              },
              child: Text('Pick a Location'),
            ),
            if (_pickedLocation != null)
              Text(_pickedLocation.toMap().toString()),
          ],
        ).vP8,
      ),
    );
  }
}
