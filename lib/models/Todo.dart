import 'package:json_annotation/json_annotation.dart';

part 'Todo.g.dart';

@JsonSerializable()
class Todo {
  Todo({
    required this.id,
    required this.name,
    required this.isCompleted,
    DateTime? createdAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
  }

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  String id;
  String name;
  bool isCompleted;
  late DateTime createdAt;

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
