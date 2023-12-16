import 'package:flutter/material.dart';

TextFormField customTextField(
    {required String hintText,
    required String labelText,
    required controller,
    Widget? icon,
    bool? readOnly,
    TextInputType? textInputType,

    String? Function(String?)? validator}) {
  return TextFormField(
    readOnly: readOnly ?? false,
    keyboardType: textInputType,
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
     
      hintText: hintText,
      label: Text(labelText),
      suffixIcon: icon,
    ),
  );
}
