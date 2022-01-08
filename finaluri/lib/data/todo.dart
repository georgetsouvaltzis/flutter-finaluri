class Todo
{
  int? id;
  String? todo;
  String? description;
  bool isDone;

  Todo({this.id, this.todo, this.description, required this.isDone});

  factory Todo.fromJson(Map<String,dynamic> json)
  {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      description: json['description'],
      isDone: json['isDone']
    );
  }

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['todo'] = todo;
    data['description'] = description;
    data['isDone'] = isDone;
    return data;
  }
}