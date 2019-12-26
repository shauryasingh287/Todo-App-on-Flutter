import 'package:equatable/equatable.dart';
import 'package:fame/model/task.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


@immutable
abstract class TaskEvent extends Equatable {
  TaskEvent([List props=const []]) :super(props);

}

class LoadTasks extends TaskEvent{
  LoadTaks(){}
}

class AddTask extends TaskEvent{
  final Task task;
  AddTask(this.task) : super([task]);
}

class DeleteTask extends TaskEvent{
  final Task task;
  DeleteTask(this.task) : super([task]);
}
