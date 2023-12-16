import 'package:flutter/material.dart';

TextFormField customTextField(
    {required String hintText, required String labelText,required controller,String? Function(String?)? validator}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(hintText: hintText, label: Text(labelText)),
  );
}
