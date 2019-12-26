import 'package:flutter/material.dart';
import 'package:fame/views/itemscreen.dart';
import 'package:fame/model/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fame/model/task.dart';

class TaskScreen extends StatefulWidget {
  @override
  createState() => new TaskScreenState();
}

class TaskScreenState extends State<TaskScreen> {
  TaskBloc _taskBloc;
  @override
  void initState() {
    super.initState();
    _taskBloc = BlocProvider.of<TaskBloc>(context);

    _taskBloc.dispatch(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Todo List')),
      body: _buildTodoTasksList(),
      floatingActionButton: new FloatingActionButton(
          onPressed:
              _pushAddTaskScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)),
    );
  }

  void _pushAddTaskScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well
        // as adding a back button to close it
        new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new task')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              if (val == '') {
              } else {
                _addTodoTask(val);
              }
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _addTodoTask(String taskname) {
    // Only add the task if the user actually entered something
    Task task = new Task(name: taskname);
    _taskBloc.dispatch(AddTask(task));
  }

  Widget _buildTodoTasksList() {
    return new BlocBuilder(
        bloc: _taskBloc,
        builder: (BuildContext context, TaskState state) {
          if (state is TasksLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TasksLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                if (index < state.tasks.length) {
                  final displayedItem = state.tasks[index];
                  return new Card(
                      child: new Container(
                    padding: EdgeInsets.only(left: 22.0, right: 22.0),
                    child: ListTile(
                      onTap: () =>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ItemScreen(displayedItem.name))),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                      
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () => _removeList(displayedItem),
                      ),title: new Text(displayedItem.name),
                    ),
                  ));
                  
                }
                return null;
              },
            );
          }
        });
  }
  void _removeList(Task displayedItem){
  _taskBloc.dispatch(DeleteTask(displayedItem));
}
}
