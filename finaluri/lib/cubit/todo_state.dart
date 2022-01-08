part of 'todo_cubit.dart';

@immutable
abstract class TodoState extends Equatable {}

class TodoInitial extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoaded extends TodoState {
  final List<Todo> todoList;

  TodoLoaded(this.todoList);

  @override
  List<Object?> get props => [todoList];
}

class TodoLoadingError extends TodoState {
  final String errorMessage;

  TodoLoadingError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
