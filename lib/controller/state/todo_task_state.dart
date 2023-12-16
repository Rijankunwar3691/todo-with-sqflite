import 'package:todowithmvc/model/todo_model.dart';

class TodoState {
 final List<ToDoModel> tasks;

  final bool isLoad;

  TodoState( {required this.tasks,required this.isLoad,});

  TodoState copyWith({List<ToDoModel>? tasks,bool? isLoad}) {
    return TodoState(tasks: tasks ?? this.tasks, isLoad: isLoad ?? this.isLoad);
  }
}
