import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:uuid/validation.dart';

import 'index.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final request = context.request;

  if (!UuidValidation.isValidUUID(fromString: id)) {
    return Response.json(
      statusCode: HttpStatus.notAcceptable,
      body: {
        'message': 'É necessário um id válido',
      },
    );
  }

  if (request.method == HttpMethod.put) {
    final body = await request.body();

    final parsedBody = jsonDecode(body) as Map<String, dynamic>;

    final name = parsedBody['name'];
    final isCompleted = parsedBody['isCompleted'];

    if (name == null || name.runtimeType != String) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'message': 'É necessário passar o nome da tarefa (String)'},
      );
    }

    if (isCompleted == null || isCompleted.runtimeType != bool) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {
          'message':
              'É necessário informar se a tarefa foi concluída ou não (bool)',
        },
      );
    }

    try {
      final updatedTodo = await service.update(
        id: id,
        name: name as String,
        isCompleted: isCompleted as bool,
      );

      return Response.json(
        body: updatedTodo,
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'message': e.message},
      );
    }
  }

  if (request.method == HttpMethod.delete) {
    try {
      final response = await service.delete(id);
      return Response.json(
        body: {'message': response},
      );
    } on FormatException catch (e) {
      return Response.json(
        statusCode: HttpStatus.badRequest,
        body: {'message': e.message},
      );
    }
  }

  return Response(statusCode: HttpStatus.notFound, body: 'Método inválido');
}
