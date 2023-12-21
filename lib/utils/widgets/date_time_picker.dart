import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String> datePicker(BuildContext context) async {
  final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2090));


  if (pickedDate != null) {
    return DateFormat('MMM dd, yyyy').format(pickedDate);
  } else {
    return '';
  }
}

Future<TimeOfDay> timePicker(BuildContext context) async {
  final pickedDate =
      await showTimePicker(context: context, initialTime: TimeOfDay.now());

  if (pickedDate != null) {
    return pickedDate;
  } else {
    return const TimeOfDay(hour: 0, minute: 0);
  }
}
