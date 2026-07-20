import 'package:hive_manager/commands/command.dart';
import 'package:hive_manager/services/hive_repository.dart';

class ListCommand implements Command 
{
  final HiveRepository service;

  ListCommand(this.service);

  @override 
  Future<void> execute() async 
  {
    for (final key in service.keys()) 
    {
      print('$key = ${service.get(key)}');
    }
  }
}