import 'package:equatable/equatable.dart';
import 'package:fame/model/item.dart';


abstract class ItemState extends Equatable {
  ItemState([List props=const []]) :super(props);
}

class ItemsLoading extends ItemState {}

class ItemsLoaded extends ItemState{
  final List<Item> items;

  ItemsLoaded(this.items) : super([items]);

}

