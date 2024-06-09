import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/home/model/m_todo.dart';
import 'package:todo_app/home/c_home.dart';
import 'package:flutter/material.dart';

class UILogicHome extends ChangeNotifier {
  TodoList? list;

  double height = 0.81;
  int skip = 0;

  final controller = HomeController();
  final userId = TextEditingController();
  final taskId = TextEditingController();
  final task = TextEditingController();

  bool prebutton = false;
  bool addnew = false;

  Future fetchData() async {
    list = await controller.fetchData(10, skip);
    notifyListeners();
  }

  Future loadCachedData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('todo_list');

    if (cachedData != null) {
      final Map<String, dynamic> data = jsonDecode(cachedData);
      list = TodoList.fromJson(data);
    } else {
      await fetchData();
    }
  }

  void next() {
    list = null;
    skip += 10;
    notifyListeners();
    fetchData();
  }

  void previous() {
    if (skip > 9) {
      list = null;
      skip -= 10;
      notifyListeners();
      fetchData();
    }
  }

  void newtask() {
    height = 0.11;
    addnew = true;
    notifyListeners();
  }

  void cancel() {
    addnew = false;
    height = 0.81;
    notifyListeners();
  }

  void updatetask(id, index) async {
    list!.todos.elementAt(index).completed =
        list!.todos.elementAt(index).completed != true ? true : false;
    await controller.updateTodoCompletedStatus(list!.todos.elementAt(index));
    notifyListeners();
  }

  void addtasks() async {
    int? id = int.tryParse(taskId.text);
    int? uid = int.tryParse(userId.text);

    if (id == null) {
      id = 0;
    }
    if (uid == null) {
      uid = 0;
    }
    Todo value = Todo(id: id, todo: task.text, completed: false, userId: uid);

    list!.todos.add(value);
    addnew = false;
    height = 0.81;
    await controller.addTodo(value);
    notifyListeners();
  }

  void deletedata(id, index) {
    TodoList lists = list!;
    list = null;
    notifyListeners();
    lists.todos.removeAt(index);
    controller.deleteTodoItem(id);
    list = lists;
    notifyListeners();
  }
}
