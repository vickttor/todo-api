import 'dart:async';

import 'package:api/models/Todo.dart';
import 'package:uuid/v4.dart';

List<Todo> mockedList = [];

class TodoService implements Exception {
  Future<Todo> create(String name) {
    final newTodo = Todo(
      id: const UuidV4().generate(),
      name: name,
      isCompleted: false,
    );

    mockedList.add(newTodo);

    return Future.value(newTodo);
  }

  Future<List<Todo>> findAll() {
    return Future.value(mockedList);
  }

  Future<Todo> update({
    required String id,
    required String name,
    required bool isCompleted,
  }) {
    final foundTask = mockedList.where((item) {
      return item.id == id;
    });

    if (foundTask.isEmpty) {
      throw const FormatException(
        'Essa tarefa não existe, por tanto não pode ser atualizada',
      );
    }

    mockedList = mockedList.map((task) {
      if (task.id == id) {
        task
          ..name = name
          ..isCompleted = isCompleted;

        return task;
      }
      return task;
    }).toList();

    final updatedTodo = mockedList.where((item) {
      return item.id == id;
    });

    return Future.value(updatedTodo.first);
  }

  Future<String> delete(String id) {
    final foundTask = mockedList.where((item) {
      return item.id == id;
    });

    if (foundTask.isEmpty) {
      throw const FormatException(
        'Essa tarefa não existe, por tanto não pode ser deletada',
      );
    }

    mockedList = mockedList.where((task) {
      return task.id != id;
    }).toList();

    return Future.value('Tarefa $id deletada');
  }
}
