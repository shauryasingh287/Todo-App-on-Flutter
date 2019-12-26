import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:fame/viewmodel/item_dao.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemDao _itemDao = ItemDao();

  @override
  ItemState get initialState => ItemsLoading();

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is LoadItems) {
      yield ItemsLoading();
      yield* _reloadItems(event.task);
    } else if (event is AddItem) {
      await _itemDao.insertItem(event.item);
      yield* _reloadItems(event.item.parent);
    } else if (event is DeleteItem) {
      await _itemDao.deleteItem(event.item);
      yield* _reloadItems(event.item.parent);
    }
    else if (event is UpdateItem) {
      await _itemDao.updateItem(event.item);
      yield* _reloadItems(event.item.parent);
    }
  }

  Stream<ItemState> _reloadItems(String task) async* {
    final items =await _itemDao.getAllItems(task);
    yield ItemsLoaded(items);
  }
}
