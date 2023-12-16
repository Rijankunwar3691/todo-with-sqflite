import 'package:todowithmvc/utils/config/db_keys.dart';

class ToDoModel {
  String? title;
  int? isCompleted;
  int? id;

  ToDoModel({required this.title, required this.isCompleted, this.id});

  factory ToDoModel.fromJson(Map<String, dynamic> json) {
    return ToDoModel(
        title: json[DbKeys.title],
        isCompleted: json[DbKeys.isCompleted],
        id: json[DbKeys.id]);
  }

  Map<String, dynamic> tojson() {
    Map<String, dynamic> data = {};
    data[DbKeys.title] = title;
    data[DbKeys.isCompleted] = isCompleted;

    return data;
  }
}
