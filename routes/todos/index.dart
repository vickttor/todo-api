import 'dart:convert';
import 'dart:io';

import 'package:api/service/Todo.dart';
import 'package:dart_frog/dart_frog.dart';

final service = TodoService();

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  if (request.method == HttpMethod.get) {
    final todoList = await service.findAll();
    return Response.json(body: todoList);
  }

  if (request.method == HttpMethod.post) {
    final body = await request.body();

    final parsedBody = jsonDecode(body) as Map<String, dynamic>;

    if (parsedBody.keys.contains('name')) {
      final name = parsedBody['name'] as String;

      if (name.isNotEmpty) {
        final createdTodo = await service.create(name);
        return Response.json(
          statusCode: HttpStatus.created,
          body: createdTodo,
        );
      }
    }

    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'message': 'É necessário passar o nome da tarefa'},
    );
  }

  return Response(statusCode: HttpStatus.notFound, body: 'Método inválido');
}
