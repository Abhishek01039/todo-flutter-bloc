part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();
}

class TodosInitial extends TodosState {
  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {
  @override
  List<Object> get props => [];
}

class TodosLoadSuccessState extends TodosState {
  final List<Todo> todos;

  const TodosLoadSuccessState([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodosLoadSuccess { todos: $todos }';
}

// class TodoAdded extends TodosState {
//   @override
//   List<Object> get props => [];
// }

class TodosLoadFailure extends TodosState {
  @override
  List<Object> get props => [];
}

class TodoInsertFailure extends TodosState {
  @override
  List<Object> get props => [];
}

class TodoInsertedSucessfully extends TodosState {
  final String id;

  TodoInsertedSucessfully({this.id});
  @override
  List<Object> get props => [id];
}
