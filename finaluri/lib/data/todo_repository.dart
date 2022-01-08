
import 'package:dio/dio.dart';
import 'package:finaluri/data/todo.dart';

class TodoRepository {
  List<Todo>? todoList = [];

  Dio dio = Dio();

  Future<List<Todo>?>? fetchTodos() async {
    final response = await dio.get("http://10.0.2.2:8080/todos");
    if(response.statusCode == 200)
      {
        var loadedTodo = <Todo>[];
        response.data.forEach((todo) {
          Todo todoModel = Todo.fromJson(todo);
          loadedTodo.add(todoModel);
          todoList = loadedTodo;
          return todoList;
        });
      }
    return todoList;
  }
  Future<void> addTodo(Todo todo) async {
    await dio.post(
        'http://10.0.2.2:8080/add-todo',
        data: todo.toJson()
    );
  }

  Future<void> updateTodo(int todoId, bool currentState) async {
    await dio.patch(
      'http://10.0.2.2:8080/todo-done/' + todoId.toString(),
      data : {
        "isDone" : !currentState
    }
    );
  }

  Future<void> deleteTodo(int todoId) async {
    await dio.delete(
      'http://10.0.2.2:8080/delete-todo/' + todoId.toString()
    );
  }
}