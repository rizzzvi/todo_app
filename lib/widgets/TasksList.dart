import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/tasksProvider.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final taskData = Provider.of<TasksProvider>(context);
    // final tasks = taskData.tasks;
    return FutureBuilder(
      future:
          Provider.of<TasksProvider>(context, listen: false).fetchAndSetData(),
      builder: (ctx, snapShot) => snapShot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<TasksProvider>(
              builder: (ctx, taskData, ch) => taskData.tasks.length <= 0
                  ? Center(
                      child: Text('You dont have any tasks'),
                    )
                  : ListView.builder(
                      itemCount: taskData.tasks.length,
                      itemBuilder: (context, index) => Container(
                        child: Column(
                          children: [
                            ListTile(
                              tileColor: index.isEven
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).primaryColor,
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                                backgroundColor: Colors.grey[200],
                              ),
                              title: Text(
                                taskData.tasks[index].title,
                              ),
                              subtitle: Text(
                                taskData.tasks[index].description,
                              ),
                              trailing: CircleAvatar(
                                backgroundColor: Theme.of(context).accentColor,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  onPressed: () {
                                    taskData.deleteTask(index);
                                    Scaffold.of(context).hideCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Deleted Successfully',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).accentColor,
                              thickness: 2,
                              height: 2,
                            )
                          ],
                        ),
                      ),
                    ),
            ),
    );
  }
}
