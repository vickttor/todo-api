// ignore_for_file: avoid_positional_boolean_parameters

import 'package:api/config/db.dart';
import 'package:api/models/Todo.dart';
import 'package:postgres/postgres.dart';

class TodoRepository {
  TodoRepository() {
    dbconfig = DatabaseConfig();
  }

  late DatabaseConfig dbconfig;

  Future<Todo> insertTodo(Todo todo) async {
    final conn = await dbconfig.connect();

    await conn.execute(
      Sql.named(
        ' INSERT INTO todos '
        ' (id, name, isCompleted, createdAt) '
        ' VALUES '
        ' (@id, @name, @isCompleted, @createdAt); ',
      ),
      parameters: todo.toJson(),
    );

    await conn.close();

    return todo;
  }

  Future<List<Todo>> findAllTodos() async {
    final conn = await dbconfig.connect();

    final result = await conn.execute('SELECT * FROM todos');

    final todos = result.map((row) {
      return Todo(
        id: row[0]! as String,
        name: row[1]! as String,
        isCompleted: row[2]! as bool,
        createdAt: row[3]! as DateTime,
      );
    }).toList();

    await conn.close();

    return todos;
  }

  Future<List<Todo>> findById(String id) async {
    final conn = await dbconfig.connect();

    final result = await conn.execute(
      r'SELECT * FROM todos WHERE id=$1',
      parameters: [id],
    );

    final todo = result.map((row) {
      return Todo(
        id: row[0]! as String,
        name: row[1]! as String,
        isCompleted: row[2]! as bool,
        createdAt: row[3]! as DateTime,
      );
    }).toList();

    await conn.close();

    return Future.value(todo);
  }

  Future<Todo> updateTodo(String id, String name, bool isCompleted) async {
    final conn = await dbconfig.connect();

    await conn.execute(
      Sql.named(
        'UPDATE todos SET name = @name, isCompleted = @isCompleted WHERE id = @id',
      ),
      parameters: {'id': id, 'name': name, 'isCompleted': isCompleted},
    );

    await conn.close();

    return Todo(id: id, name: name, isCompleted: isCompleted);
  }

  Future<void> deleteTodo(String id) async {
    final conn = await dbconfig.connect();

    await conn.execute(
      Sql.named('DELETE FROM todos WHERE id = @id'),
      parameters: {'id': id},
    );

    await conn.close();
  }
}
