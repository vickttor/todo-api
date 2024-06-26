import 'dart:async';

import 'package:api/models/Todo.dart';
import 'package:api/repositories/Todo.dart';
import 'package:uuid/v4.dart';

List<Todo> mockedList = [];

class TodoService implements Exception {
  TodoService() {
    repository = TodoRepository();
  }

  late TodoRepository repository;

  Future<Todo> create(String name) async {
    final newTodo = Todo(
      id: const UuidV4().generate(),
      name: name,
      isCompleted: false,
    );

    await repository.insertTodo(newTodo);

    return newTodo;
  }

  Future<List<Todo>> findAll() {
    return repository.findAllTodos();
  }

  Future<Todo> update({
    required String id,
    required String name,
    required bool isCompleted,
  }) async {
    final foundTask = await repository.findById(id);

    if (foundTask.isEmpty) {
      throw const FormatException(
        'Essa tarefa não existe, por tanto não pode ser atualizada',
      );
    }

    final updatedTodo = await repository.updateTodo(id, name, isCompleted);

    return updatedTodo;
  }

  Future<String> delete(String id) async {
    final foundTask = await repository.findById(id);

    if (foundTask.isEmpty) {
      throw const FormatException(
        'Essa tarefa não existe, por tanto não pode ser deletada',
      );
    }

    await repository.deleteTodo(id);

    return Future.value('Tarefa $id deletada');
  }
}
