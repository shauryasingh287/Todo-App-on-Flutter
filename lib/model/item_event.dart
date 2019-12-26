import 'package:equatable/equatable.dart';
import 'package:fame/model/item.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


@immutable
abstract class ItemEvent extends Equatable {
  ItemEvent([List props=const []]) :super(props);

}

class LoadItems extends ItemEvent{
  final String task;
  LoadItems(this.task);
}

class AddItem extends ItemEvent{
  final Item item;
  AddItem(this.item) : super([item]);
}

class DeleteItem extends ItemEvent{
  final Item item;
  DeleteItem(this.item) : super([item]);
}
class UpdateItem extends ItemEvent{
  final Item item;
  UpdateItem(this.item) : super([item]);
}
