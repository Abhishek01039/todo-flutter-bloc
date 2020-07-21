import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable(nullable: false)
class Todo extends Equatable {
  bool complete;
  final String id;
  final String note;
  final String task;

  Todo({
    this.task,
    this.complete = false,
    this.note = '',
    this.id,
  });

  @override
  List<Object> get props => [
        complete,
        id,
        note,
        task,
      ];

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
