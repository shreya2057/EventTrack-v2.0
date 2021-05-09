import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../model/event.dart';
import '../../../picker/filepicker.dart';
import '../../../states/events.dart';
import '../../../theme/extension.dart';
import '../../../theme/text_styles.dart';
import '../detail/home.screen.dart';

class UploadEventCover extends StatelessWidget {
  final RxBool _isUploading = false.obs;

  final _cover = Rx<File>();
  void _pickedImage(File image) {
    _cover.value = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text(
                'Upload a Cover for the Event',
                style: TextStyles.titleM.copyWith(fontWeight: FontWeight.w600),
              ),
              PickaFile(_pickedImage).vP16,
            ],
          ),
          Obx(
            () => !_isUploading.value
                ? RoundedButton(
                    text: 'Upload',
                    onPress: () async {
                      _isUploading.value = true;
                      Event.to.loadEvent(
                          EventModel(eventCover: _cover.value), 'cover');
                      await Event.to.uploadCover(_cover.value).then((res) {
                        if (!res.status) {
                          FlashMessage.errorFlash(res.message);
                        } else {
                          Event.to.loadEvent(
                              EventModel(eventCoverUrl: res.value), 'coverUrl');
                          Get.off(() => HomeScreen());
                        }
                      });
                      _isUploading.value = false;
                    },
                  )
                : CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
