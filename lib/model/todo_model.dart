import 'package:todowithmvc/utils/config/db_keys.dart';

class ToDoModel {
  String? title, date, time;
  int? isCompleted;
  int? id;

  ToDoModel(
      {required this.title,
      required this.isCompleted,
      this.id,
      required this.date,
      required this.time});

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
        title: json[DbKeys.title],
        isCompleted: json[DbKeys.isCompleted],
        id: json[DbKeys.id],
        date: json[DbKeys.date],
        time: json[DbKeys.time]);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = {};
    data[DbKeys.title] = title;
    data[DbKeys.isCompleted] = isCompleted;
    data[DbKeys.date] = date;
    data[DbKeys.time] = time;

    return data;
  }
}
