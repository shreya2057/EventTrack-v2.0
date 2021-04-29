import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/message.dart';
import '../../../components/rounded_button.dart';
import '../../../components/categoryBar.dart';
import '../../../components/textarea.dart';
import '../../../model/event.dart';
import '../../../routes.dart';
import '../../../theme/extension.dart';
import '../../../theme/text_styles.dart';

List<String> avCategories = [
  'Award',
  'Competition',
  'Educational',
  'Festival',
  'Networking',
  'Science & Technology',
  'Seminar',
  'Social',
  'Sports',
  'Trade',
  'Workshop',
  'Others'
];

class CreateEventForm extends StatelessWidget {
  final RxString _title = ''.obs;
  final RxString _description = ''.obs;
  final RxList _selectedCategories = [].obs;

  validation() {
    if (_title.value.trim().isEmpty) {
      FlashMessage.errorFlash('Empty Title');
      return false;
    } else if (_selectedCategories.length < 1) {
      FlashMessage.errorFlash('Please select at least one category.');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "Create Your Event",
                style: TextStyles.h1Style,
              ),
              Column(
                children: [
                  TextArea(
                    hintText: "Event Name",
                    maxlines: 2,
                    maxlength: 50,
                    autofocus: true,
                    capitalization: TextCapitalization.sentences,
                    controller: _title,
                  ),
                  TextArea(
                    hintText: "Description",
                    autofocus: true,
                    controller: _description,
                    capitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    maxlines: 6,
                    maxlength: 250,
                  ),
                  Text(
                    "Select Event Categories",
                    style: TextStyles.titleM,
                  ),
                  Wrap(
                    children: [
                      for (var i = 0; i < avCategories.length; i++)
                        CategoryBar(
                          avCategories[i],
                          onChanged: (bool value) {
                            if (value &&
                                !_selectedCategories
                                    .contains(avCategories[i])) {
                              _selectedCategories.add(avCategories[i]);
                            } else {
                              _selectedCategories.remove(
                                  _selectedCategories.indexOf(avCategories[i]));
                            }
                          },
                        ),
                    ],
                  ),
                  RoundedButton(
                    text: "Next",
                    onPress: () {
                      FocusScope.of(context).unfocus();

                      final newEvent = EventModel(
                        title: _title.value.trim(),
                        description: _description.value.trim(),
                        categories: _selectedCategories.toList(),
                      );

                      if (validation()) {
                        // EventServer.eventform(newEvent.toMap()).then((res) async {
                        //   if (!res.status) {
                        //     FlashMessage.errorFlash(res.message);
                        //   } else {
                        Get.offNamed(
                          Routes.eventExtraInput,
                          arguments: newEvent,
                        );
                        // }
                        // });
                      }
                    },
                  ),
                ],
              ),
            ],
          ).p(16),
        ),
      ),
    );
  }
}
