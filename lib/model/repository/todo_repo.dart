import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todowithmvc/model/todo_model.dart';
import 'package:todowithmvc/utils/config/db_helper.dart.dart';
import 'package:todowithmvc/utils/config/db_keys.dart';

final todoRepoProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepository();
});

class ToDoRepository {
  Future<void> addTodo(ToDoModel todo) async {
    final todos = todo.tojson();
    final db = await DataBaseConfig().setDatabase();

    db.insert(DbKeys.table, todos);
  }

  Future<List<ToDoModel>> getTodo() async {
    final db = await DataBaseConfig().setDatabase();

    List<Map<String, dynamic>> data =
        await db.query(DbKeys.table, orderBy: '${DbKeys.id} DESC');

    return List.generate(data.length, (index) {
      return ToDoModel.fromJson(data[index]);
    });
  }

  Future<void> deleteTodo(int id) async {
    final db = await DataBaseConfig().setDatabase();
    await db.delete(DbKeys.table, where: '${DbKeys.id} = ?', whereArgs: [id]);
  }

  Future<void> updateTodo(ToDoModel toDoModel) async {
    final db = await DataBaseConfig().setDatabase();
    final todo = toDoModel.tojson();

    await db.update(DbKeys.table, todo,
        where: '${DbKeys.id} = ?', whereArgs: [toDoModel.id]);
  }
}
