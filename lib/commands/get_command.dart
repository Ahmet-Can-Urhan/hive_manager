//Filter the hive file with a specific key

import 'package:hive_manager/commands/command.dart';
import 'package:hive_manager/services/hive_repository.dart';

class GetCommand implements Command
{
  final HiveRepository _repository;
  final dynamic _key;

  GetCommand(this._repository,this._key);

  @override
  Future<void> execute() async
  {
    final value = _repository.get((_key));

    if (value == null) 
    {
      print("Error: key '$_key' not found.");
      return;
    }
    print(value);
  }
}