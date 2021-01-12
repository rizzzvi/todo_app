import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasksProvider.dart';
import 'package:todo_app/widgets/TasksList.dart';
import 'package:todo_app/widgets/theme_switch.dart';

// ignore: must_be_immutable
class ToDoList extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TasksProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.color,
        title: Text('Todo App'),
        actions: [
          Row(
            children: [
              Text('Dark Mode'),
              ThemeSwitch(),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return buildAlertDialog(context, taskData);
                  });
            },
          ),
        ],
      ),
      body: TasksList(),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, TasksProvider taskData) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      titlePadding: EdgeInsets.only(
        top: 12,
      ),
      title: Text(
        'New Task',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 140,
        width: 400,
        child: SingleChildScrollView(
          child: ListBody(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                maxLines: 2,
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _titleController.clear();
            _descriptionController.clear();
            Navigator.of(context).pop();
          },
          child: Text(
            'CANCEL',
          ),
        ),
        TextButton(
          onPressed: () {
            title = _titleController.text;
            description = _descriptionController.text;
            Navigator.of(context).pop();
            _titleController.clear();
            _descriptionController.clear();
            taskData.addTask(
              DateTime.now().toString(),
              title,
              description,
            );
          },
          child: Text(
            'ADD',
          ),
        ),
      ],
    );
  }
}
