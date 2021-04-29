import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/light_color.dart';
import '../theme/text_styles.dart';

class CategoryBar extends StatelessWidget {
  CategoryBar(this.category, {this.onChanged});
  final String category;
  final Function(bool) onChanged;
  final RxBool isSelected = false.obs;

  toggleSelection(value) {
    isSelected.value = !isSelected.value;
    onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width * 0.45,
        child: CheckboxListTile(
          title: Text(
            category,
            style: TextStyles.body,
          ),
          value: isSelected.value,
          onChanged: toggleSelection,
          selectedTileColor: LightColor.lightBlack,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      ),
    );
  }
}
