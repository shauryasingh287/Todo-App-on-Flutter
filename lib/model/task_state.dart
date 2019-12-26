import 'package:equatable/equatable.dart';
import 'package:fame/model/task.dart';


abstract class TaskState extends Equatable {
  TaskState([List props=const []]) :super(props);
}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState{
  final List<Task> tasks;

  TasksLoaded(this.tasks) : super([tasks]);

}

