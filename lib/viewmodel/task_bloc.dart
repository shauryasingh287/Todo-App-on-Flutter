import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fame/model/bloc.dart';
import 'package:fame/viewmodel/task_dao.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskDao _taskDao = TaskDao();

  @override
  TaskState get initialState => TasksLoading();

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is LoadTasks) {
      yield TasksLoading();
      yield* _reloadTasks();
    } else if (event is AddTask) {
      await _taskDao.insertTask(event.task);
      yield* _reloadTasks();
    } else if (event is DeleteTask) {
      await _taskDao.deleteTask(event.task);
      yield* _reloadTasks();
    }
  }

  Stream<TaskState> _reloadTasks() async* {
    final tasks =await _taskDao.getAllTasks();
    yield TasksLoaded(tasks);
  }
}
