class TodoList {
  List<Todo> todos;

  TodoList({required this.todos});

  factory TodoList.fromJson(Map<String, dynamic> json) {
    var list = json['todos'] as List;
    List<Todo> todosList = list.map((i) => Todo.fromJson(i)).toList();
    return TodoList(todos: todosList);
  }

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
    };
  }
}

class Todo {
  final int id;
  final String todo;
  bool completed;
  final int userId;

  Todo({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }
}
