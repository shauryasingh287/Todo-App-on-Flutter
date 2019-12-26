import 'package:meta/meta.dart';

class Item{
  int id;

  final String name;
  final String parent;
  final bool completed;

  Item({
    @required this.name, this.parent,this.completed=false,this.id
  });

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'parent' : parent,
      'completed' : completed,
    };
  }
 
  static Item fromMap(Map<String ,dynamic> map){
    return  Item(
      name : map['name'],
      parent : map['parent'],
      completed : map['completed']
    );
  }
}