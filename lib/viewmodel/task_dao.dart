import 'package:sembast/sembast.dart';
import 'package:fame/database/database.dart';
import 'package:fame/model/task.dart';

class TaskDao{

  static const String TASK_LIST_NAME='tasks';

  final _taskList = intMapStoreFactory.store(TASK_LIST_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertTask(Task task) async {
    await _taskList.add(await _db, task.toMap());
  }

  Future updateTask(Task task) async {
   
    final finder = Finder(filter: Filter.byKey(task.id));
    await _taskList.update(
      await _db,
      task.toMap(),
      finder: finder,
    );
  }
  Future deleteTask(Task task) async {
   
    final finder = Finder(filter: Filter.byKey(task.id));
    await _taskList.delete(
      await _db,
      finder: finder,
    );
  }
  
  Future<List<Task>> getAllTasks() async {
      final finder = Finder();
      final recordSnapshots = await _taskList.find(
        await _db,
        finder: finder,
      ) ;

      return recordSnapshots.map((snapshot){
        final task= Task.fromMap(snapshot.value);

        task.id=snapshot.key;
        return task;
      }).toList();

  }

  





}
