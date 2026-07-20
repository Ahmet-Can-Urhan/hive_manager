import 'package:args/args.dart';
import 'package:hive_manager/commands/get_command.dart';
import 'package:hive_manager/services/hive_repository.dart';
import 'package:hive_manager/commands/list_command.dart';
import 'package:hive_manager/utils/key_parser.dart';

class CommandRunner 
{
  final ArgParser _parser = ArgParser()
  
  ..addOption(
    'db',
    abbr: 'd',
    help: 'Path to Hive database directory',
  )
  ..addOption(
    'box',
    abbr: 'b',
    help: 'Hive box name',
  )
  ..addFlag(
    'help',
    abbr:'h',
    negatable: false,
    help: 'Show usage information',
  );

  Future<void> run(List<String> arguments) async 
  {
    ArgResults results;
    try 
    {
      results = _parser.parse(arguments);
    } on FormatException catch (e) 
    {
      print(e.message);
      _printUsage();
     
      return;
    }
    await _executeCommand(results);
    
  }

  
  Future<void> _executeCommand( ArgResults results) async 
  {
  
    if (results['help'] as bool) {
      _printUsage();
      return;
    }

    if (results['db'] == null) {
      print("Error: missing required option '--db'.");
      return;
      }

    if (results['box'] == null) {
        print("Error: missing required option '--box'.");
        return;
        }
    if (results.rest.isEmpty) {
        print('Error: Missing command.');
        return;
    }
    final repository =  HiveRepository();
    try {
    await repository.open(databasePath: results['db'] as String, boxName: results['box'] as String);
    final command = results.rest.first;

    switch (command) 
    {
      case 'list':
        await ListCommand(repository).execute();
        break;
      case 'get': 
        final key = parseKey(results.rest.last);
        await GetCommand(repository,key).execute();
        
      default:
        print("Unknown command: '$command'.");
    }
    
    } 
    finally 
    {
      await repository.close();
    }


  }

  void _printUsage() 
  {
      print('Usage:');
      print('  hive_manager --db <path> --box <box> <command>');
      print('');
      print(_parser.usage);    
  }
}