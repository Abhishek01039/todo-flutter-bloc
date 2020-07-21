part of 'tododetail_bloc.dart';

abstract class TododetailEvent extends Equatable {
  const TododetailEvent();
}

class TododetailLoadedEvent extends TododetailEvent {
  @override
  List<Object> get props => [];
}

class TododetailLoadingEvent extends TododetailEvent {
  @override
  List<Object> get props => [];
}
