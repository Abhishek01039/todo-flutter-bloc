import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/services/todoService.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial());
  final TodoServices _todoServices = TodoServices();

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is TodosLoadSuccess) {
      _mapLoadingToSuccess();
    }
    if (event is TodoAdded) {
      yield* _mapToLodingToAdd(event.todo);
    }
    if (event is TodosLoading) {
      yield TodosLoadSuccessState();
    }
  }

  _mapLoadingToSuccess() async* {
    yield TodosLoadInProgress();
    //TODO: data coming from firebase
    yield TodosLoadSuccessState();
  }

  Stream<TodosState> _mapToLodingToAdd(Todo todo) async* {
    yield TodosLoadInProgress();
    try {
      String data = await _todoServices.insertData(todo);
      if (data != null) {
        yield TodoInsertedSucessfully(id: data);
      } else {
        yield TodoInsertFailure();
      }
    } catch (e) {
      yield TodoInsertFailure();
    }
  }
}
