import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../theme/extension.dart';

class PickaFile extends StatelessWidget {
  final Function(File) pickFileFn;
  final List<String> extensions;
  final FileType fileType;

  PickaFile(
    this.pickFileFn, {
    this.fileType = FileType.image,
    this.extensions,
  }) : assert(fileType != FileType.custom || extensions.length > 0);

  final Rx<PlatformFile> _path = PlatformFile().obs;

  Future _pickFile() async {
    try {
      _path.value = await _picked();
      pickFileFn(File(_path.value.path));
    } catch (e) {
      print(e);
    }
  }

  Future<PlatformFile> _picked() async {
    return (await FilePicker.platform
            .pickFiles(type: fileType, allowedExtensions: extensions))
        .files
        .first;
  }

  @override
  Widget build(BuildContext context) {
    return _eventCover();
  }

  Widget _eventCover() {
    return Obx(() {
      return Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: Get.width * 0.95,
            height: Get.height * 0.25,
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5),
                image: _path.value.path != null
                    ? DecorationImage(
                        image: FileImage(File(_path.value.path)),
                        fit: BoxFit.cover,
                      )
                    : null),
          ),
          TextButton.icon(
            onPressed: _pickFile,
            icon: Icon(_path.value.path == null ? Icons.add : Icons.swap_horiz),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Colors.grey.shade300.withOpacity(0.8)),
            ),
            label: Text(_path.value.path == null ? 'Add Image' : 'Change Image')
                .p(4),
          ),
        ],
      ).alignCenter;
    });
  }
}
