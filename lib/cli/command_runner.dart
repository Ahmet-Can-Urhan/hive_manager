import 'package:args/args.dart';

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
      _printUsage();
      print(_parser.usage);
      return;
    }
    if (results['help'] as bool) {
      _printUsage();
      print(_parser.usage);
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
  }

  void _printUsage() 
  {
      print('Usage:');
      print('  hive_manager --db <path> --box <box> <command>');
      print('');
      print(_parser.usage);    
  }
}