import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todowithmvc/utils/config/db_keys.dart';

class DataBaseConfig {
  Future<Database> setDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'db_todo');

    final db = openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    return db.execute(
        'CREATE TABLE ${DbKeys.table}(${DbKeys.id} INTEGER PRIMARY KEY AUTOINCREMENT,${DbKeys.title} TEXT , ${DbKeys.isCompleted} INTEGER)');
  }
}
