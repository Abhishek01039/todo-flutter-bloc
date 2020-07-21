part of 'tododetail_bloc.dart';

abstract class TododetailState extends Equatable {
  const TododetailState();
}

class TododetailInitial extends TododetailState {
  @override
  List<Object> get props => [];
}

class TododetailLoadedState extends TododetailState {
  @override
  List<Object> get props => [];
}

class TodoDetailError extends TododetailState {
  @override
  List<Object> get props => throw UnimplementedError();
}
