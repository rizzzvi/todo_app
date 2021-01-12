import 'package:flutter/foundation.dart';
import 'package:todo_app/helpers/db_helper.dart';
import 'package:todo_app/models/task.dart';
import 'package:provider/provider.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks {
    return [..._tasks];
  }

  void addTask(String id, String title, String description) {
    // ignore: await_only_futures
    _tasks.add(
      Task(id: id, title: title, description: description),
    );
    notifyListeners();
    DBHelper.insert(
      'tasks',
      {
        'id': id,
        'title': title,
        'description': description,
      },
    );
  }

  void deleteTask(int index) async {
    await DBHelper.deleteTask('tasks', _tasks[index].id);
    _tasks.removeAt(index);
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    List dataList = await DBHelper.getData('tasks');
    _tasks = dataList
        .map(
          (task) => Task(
            id: task['id'],
            title: task['title'],
            description: task['description'],
          ),
        )
        .toList();
    notifyListeners();
  }
}
