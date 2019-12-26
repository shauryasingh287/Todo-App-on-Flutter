import 'package:sembast/sembast.dart';
import 'package:fame/database/database.dart';
import 'package:fame/model/item.dart';

class ItemDao{

  static const String ITEM_LIST_NAME='items';

  final _itemList = intMapStoreFactory.store(ITEM_LIST_NAME);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insertItem(Item item) async {
    await _itemList.add(await _db, item.toMap());
  }

  Future updateItem(Item item) async {
   
    final finder = Finder(filter: Filter.byKey(item.id));
    await _itemList.update(
      await _db,
      item.toMap(),
      finder: finder,
    );
  }
  Future deleteItem(Item item) async {
   
    final finder = Finder(filter: Filter.byKey(item.id));
    print('after'+item.id.toString());
    await _itemList.delete(
      await _db,
      finder: finder,
    );
  }
  
  Future<List<Item>> getAllItems(String task) async {
      final finder = Finder(filter: Filter.equals('parent', task));
      final recordSnapshots = await _itemList.find(
        await _db,
        finder: finder,
      ) ;

      return recordSnapshots.map((snapshot){
        final item = Item.fromMap(snapshot.value);

        item.id=snapshot.key;
        return item;
      }).toList();

  }

  





}
