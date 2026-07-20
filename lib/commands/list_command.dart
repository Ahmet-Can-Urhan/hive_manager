import 'package:hive_manager/commands/command.dart';
import 'package:hive_manager/services/hive_repository.dart';

class ListCommand implements Command 
{
  final HiveRepository repository;

  ListCommand(this.repository);

  @override 
  Future<void> execute() async 
  {
    for (final key in repository.keys()) 
    {
      print('$key = ${repository.get(key)}');
    }
  }
}