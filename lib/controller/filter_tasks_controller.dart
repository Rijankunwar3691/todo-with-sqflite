import 'package:todowithmvc/model/todo_model.dart';

filterIncompleteTasks(List<ToDoModel> todos) {
  List<ToDoModel> flitered = [];

  for (final todo in todos) {
    if (todo.isCompleted == 0) {
      flitered.add(todo);
    }
  }
  return flitered;
}

filterCompletedTasks(List<ToDoModel> todos) {
  List<ToDoModel> flitered = [];

  for (final todo in todos) {
    if (todo.isCompleted == 1) {
      flitered.add(todo);
    }
  }
  return flitered;
}
