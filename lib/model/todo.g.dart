// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
    title: json['title'] as String,
    complete: json['complete'] as bool,
    desc: json['desc'] as String ?? "",
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'complete': instance.complete,
      'id': instance.id,
      'title': instance.title,
      'desc': instance.desc,
    };
