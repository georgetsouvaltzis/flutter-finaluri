import 'package:equatable/equatable.dart';
import 'package:finaluri/data/todo.dart';
import 'package:finaluri/data/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final todoRepository = TodoRepository();
  static int todoCount = 0;

  Future<void> fetchTodos() async {
    emit(TodoInitial());
    try {
      var todoList = await todoRepository.fetchTodos();
      todoCount = todoList!.length;
      emit(TodoLoaded(todoList));
    } catch (e) {
      emit(
        TodoLoadingError(e.toString()),
      );
    }
  }

  // Future<void> deleteTodo(int id) async {
  //   await todoRepository.deleteTodo(id);
  //   var f = await todoRepository.fetchTodos();
  //   emit(TodoLoaded(f!));
  // }
  //
  Future<void> addTodo(Todo todo) async {
    await todoRepository.addTodo(todo);
    var f = await todoRepository.fetchTodos();
    emit(TodoLoaded(f!));
  }
  Future<void> updateTodo(int todoId, bool currentState) async {
    await todoRepository.updateTodo(todoId, currentState);
    var f=  await todoRepository.fetchTodos();
    emit(TodoLoaded(f!));
  }

  Future<void> deleteTodo(int todoId) async {
    await todoRepository.deleteTodo(todoId);
    var f= await todoRepository.fetchTodos();
    emit(TodoLoaded(f!));
  }
  //
  // Future<void> editTodo(Todo todo) async {
  //   await todoRepository.editTodo(todo);
  //   var f = await todoRepository.fetchTodos();
  //   emit(TodoLoaded(f!));
  // }
}