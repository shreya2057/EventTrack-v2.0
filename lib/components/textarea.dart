import 'package:flutter/material.dart';

import 'rounded_input_field.dart';

class TextArea extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final TextCapitalization capitalization;
  final bool enableSuggesstion;
  final FormFieldValidator<String> validator;
  final void Function(String) controller;
  final Key key;
  final int maxlines;
  final int maxlength;
  final bool autofocus;
  final String value;
  const TextArea({
    this.key,
    this.hintText,
    this.validator,
    this.controller,
    this.value,
    this.keyboardType = TextInputType.text,
    this.capitalization = TextCapitalization.none,
    this.enableSuggesstion = false,
    this.maxlines,
    this.maxlength,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: double.infinity,
      child: TextFormField(
        key: key,
        autocorrect: false,
        autofocus: autofocus,
        textCapitalization: capitalization,
        enableSuggestions: enableSuggesstion,
        keyboardType: keyboardType,
        onChanged: controller,
        validator: validator,
        initialValue: value,
        maxLength: maxlength,
        maxLines: maxlines,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
