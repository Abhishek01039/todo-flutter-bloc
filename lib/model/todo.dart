import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo.g.dart';

@JsonSerializable(nullable: false)
class Todo extends Equatable {
  bool complete;
  final String id;
  final String title;
  final String desc;

  Todo({
    this.title,
    this.complete = false,
    this.desc,
    this.id,
  });

  @override
  List<Object> get props => [
        complete,
        id,
        title,
        desc,
      ];

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
