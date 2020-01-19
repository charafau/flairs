import 'package:flair/command/init/init_command.dart';
import 'package:flair/flair.dart' as flair;
import 'package:args/args.dart';
import 'package:flair/utils/package_reader.dart';

void main(List<String> arguments) {
  final parser = ArgParser()..addCommand('init');
  final parse = parser.parse(arguments);

  final appName = PackageReader().readPackageName();
  if (appName != null) {
    var initCommand = InitCommand(appName: appName);
    initCommand.checkActions(parse);
  }
//  initCommand.checkActions(parse);
}
