import 'package:flutter/material.dart';
import 'package:fame/views/taskscreen.dart';
import 'package:fame/model/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    // Wrapping the whole app with BlocProvider to get access to FruitBloc everywhere
    // BlocProvider extends InheritedWidget.
    return BlocProvider(
      bloc: TaskBloc(),
      child: MaterialApp(
        title: 'Flutter Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.lightBlue,
        ),
        home: TaskScreen(),
      ),
    );
  }
}


  

