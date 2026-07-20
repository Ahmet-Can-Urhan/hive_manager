import 'package:hive/hive.dart';

class HiveRepository
{
  late final Box<dynamic> _box;

  Future<void> open(
    {
      required String databasePath,
      required String boxName,
    }) async 
    {
      Hive.init(databasePath);
      _box = await Hive.openBox(boxName);
    }

    Iterable<dynamic> keys() 
    {
      return _box.keys;
    }

    dynamic get(dynamic key) 
    {
      return _box.get(key);
    }
    dynamic getAll() 
    {
      for (int i = 0; i < _box.length; i++)  
      {
        get(i);
      }
    }
    Future<void> put(dynamic key, dynamic value) async 
    {
      await _box.put(key,value);
    }

    Future<void> delete(dynamic key) async 
    {
      await _box.delete(key);
    }

    Future<void> close() async 
    {
      await _box.close();
    }
}