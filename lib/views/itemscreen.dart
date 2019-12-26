import 'package:flutter/material.dart';
import 'package:fame/model/item.dart';
import 'package:fame/model/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemScreen extends StatefulWidget {
  final String task;
  ItemScreen(this.task);
  @override
  State<StatefulWidget> createState() {
    return new ItemScreenState(task);
  }
}

class ItemScreenState extends State<ItemScreen> {
  ItemBloc _itemBloc = ItemBloc();
  String task;
  ItemScreenState(this.task);
  @override
  void initState() {
    super.initState();
    _itemBloc = ItemBloc();
    _itemBloc.dispatch(LoadItems(task));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TaskBloc(),
      child: MaterialApp(
          home: new Scaffold(
        appBar: new AppBar(title: new Text('Item List')),
        body: _buildTodoItemsList(),
        floatingActionButton: new FloatingActionButton(
            onPressed:
                _pushAddItemScreen, // pressing this button now opens the new screen
            tooltip: 'Add task',
            child: new Icon(Icons.add)),
      )),
    );
  }

  void _pushAddItemScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
        // MaterialPageRoute will automatically animate the screen entry, as well
        // as adding a back button to close it
        new MaterialPageRoute(builder: (context) {
      return new Scaffold(
          appBar: new AppBar(title: new Text('Add a new Item')),
          body: new TextField(
            autofocus: true,
            onSubmitted: (val) {
              if (val == '') {
              } else {
                _addTodoItem(val);
              }
              Navigator.pop(context); // Close the add todo screen
            },
            decoration: new InputDecoration(
                hintText: 'Enter something to do...',
                contentPadding: const EdgeInsets.all(16.0)),
          ));
    }));
  }

  void _addTodoItem(String itemname) {
    Item item = new Item(name: itemname, parent: task);
    // Only add the task if the user actually entered something

    _itemBloc.dispatch(AddItem(item));
  }

  Widget _buildTodoItemsList() {
    return new BlocBuilder(
        bloc: _itemBloc,
        builder: (BuildContext context, ItemState state) {
          if (state is ItemsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ItemsLoaded) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                if (index < state.items.length) {
                  final displayedItem = state.items[index];
                  return new Card(
                      child: new Container(
                    padding: EdgeInsets.only(left: 22.0, right: 22.0),
                    child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 8.0),
                      leading: Checkbox(
                        onChanged: (value) => _updateItem(displayedItem),
                        value: displayedItem.completed,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () => _removeTodoItem(displayedItem),
                      ),title: new Text(displayedItem.name),
                    ),
                  ));
                 
                }
                return null;
              },
            );
          }
        }
        //   itemBuilder: (context, index) {

        );
  }

  void _removeTodoItem(Item item) {
    _itemBloc.dispatch(DeleteItem(item));
  }

  void _promptRemoveTodoItem(Item item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(title: new Text('Delete?'), actions: <Widget>[
            new FlatButton(
                child: new Text('No'),
                onPressed: () => Navigator.of(context).pop()),
            new FlatButton(
                child: new Text('Yes'),
                onPressed: () {
                  _removeTodoItem(item);
                  Navigator.of(context).pop();
                })
          ]);
        });
  }

  void _updateItem(Item item) {
    Item upd = new Item(
        name: item.name,
        completed: item.completed ^ true,
        id: item.id,
        parent: item.parent);
    _itemBloc.dispatch(UpdateItem(upd));
  }
}
