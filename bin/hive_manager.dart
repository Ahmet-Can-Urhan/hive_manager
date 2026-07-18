import 'package:hive_manager/cli/command_runner.dart';

Future<void> main(List<String> args) async 
{
  await CommandRunner().run(args);  
}
