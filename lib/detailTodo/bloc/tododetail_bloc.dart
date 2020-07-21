import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tododetail_event.dart';
part 'tododetail_state.dart';

class TododetailBloc extends Bloc<TododetailEvent, TododetailState> {
  TododetailBloc() : super(TododetailInitial());

  @override
  Stream<TododetailState> mapEventToState(
    TododetailEvent event,
  ) async* {
    if (event is TododetailLoadingEvent) {
      yield* _mapLoadingToLoaded();
    }
    if (event is TododetailLoadedEvent) {
      yield TododetailLoadedState();
    }
  }

  Stream<TododetailState> _mapLoadingToLoaded() async* {
    yield TododetailInitial();
    try {
      Future.delayed(
        Duration(seconds: 3),
      );
      yield TododetailLoadedState();
    } catch (e) {
      yield TodoDetailError();
    }
  }
}
