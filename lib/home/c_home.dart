import 'package:todo_app/home/model/m_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController {
  TodoList? list;

  Future<TodoList> fetchData(limit, skip) async {
    {
      try {
        final res = await http.get(
          Uri.parse('https://dummyjson.com/todos?limit=$limit&skip=$skip'),
        );

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          list = TodoList.fromJson(data);
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('todo_list', jsonEncode(data));
        }
      } catch (_) {
      } finally {
        list ?? '';
      }
      return list!;
    }
  }

  Future<void> deleteTodoItem(int id) async {
    final url = Uri.parse('https://dummyjson.com/todos/$id');

    final res = await http.delete(url);

    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      print(json);
    } else {
      throw Exception('Failed to delete the todo item');
    }
  }

  Future<void> addTodo(Todo value) async {
    final Uri url = Uri.parse('https://dummyjson.com/todos/add');
    final Map<String, dynamic> data = {
      'todo': value.todo,
      'completed': value.completed,
      'userId': value.userId,
    };

    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      final dynamic jsonResponse = json.decode(response.body);
      print(jsonResponse);
    } else {
      throw Exception('Failed to add todo: ${response.statusCode}');
    }
  }

  Future<void> updateTodoCompletedStatus(Todo value) async {
    final Uri url = Uri.parse('https://dummyjson.com/todos/${value.id}');
    final Map<String, dynamic> data = {'completed': value.completed};

    final http.Response res = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (res.statusCode == 200) {
      final dynamic jsonResponse = json.decode(res.body);
      print(jsonResponse);
    } else {
      throw Exception('Failed to update todo status: ${res.statusCode}');
    }
  }
}
