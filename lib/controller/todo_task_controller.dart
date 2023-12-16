import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todowithmvc/controller/state/todo_task_state.dart';
import 'package:todowithmvc/model/repository/todo_repo.dart';
import 'package:todowithmvc/model/todo_model.dart';

final todoProvider = StateNotifierProvider<TodoTaskNotifier, TodoState>((ref) {
  final toDoRepository = ref.watch(todoRepoProvider);
  return TodoTaskNotifier(toDoRepository: toDoRepository);
});

class TodoTaskNotifier extends StateNotifier<TodoState> {
  final ToDoRepository toDoRepository;
  TodoTaskNotifier({required this.toDoRepository})
      : super(TodoState(tasks: [], isLoad: false)) {
    getTodo();
  }

  Future<void> addTodo(ToDoModel todo) async {
    await toDoRepository.addTodo(todo);
    getTodo();
  }

  Future<void> getTodo() async {
    state = state.copyWith(isLoad: true);
    final tasks = await toDoRepository.getTodo();
    state = state.copyWith(tasks: tasks, isLoad: false);
  }

  Future<void> deleteTodo(int id) async {
    await toDoRepository.deleteTodo(id);
    getTodo();
  }

  Future<void> updateToDo(ToDoModel toDoModel) async {
    await toDoRepository.updateTodo(toDoModel);
    getTodo();
  }
}
