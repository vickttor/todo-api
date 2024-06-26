import 'package:api/config/db.dart';
import 'package:api/models/Todo.dart';
import 'package:postgres/postgres.dart';

class TodoRepository {
  TodoRepository() {
    initilize(DatabaseConfig());
  }

  late Connection _connection;

  Future<void> initilize(DatabaseConfig dbconfig) async {
    _connection = await dbconfig.connect();
    await dbconfig.initilize(_connection);
  }

  Future<void> insertTodo(Todo todo) async {
    final result = await _connection.execute(
      ' INSERT INTO todos '
      ' (id, name, isCompleted, createdAt) '
      ' VALUES (${todo.id}, ${todo.name}, ${todo.isCompleted}, ${todo.isCompleted}); ',
    );

    print("RESULT");
    print(result);
  }
}
