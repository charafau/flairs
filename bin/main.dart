import 'package:flairs/command/init/init_command.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:args/args.dart';
import 'package:flairs/dependencies_writer.dart';
import 'package:flairs/utils/package_reader.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('init')
    ..addCommand('scaffold')
    ..addOption('feature', abbr: 'f');
  final parse = parser.parse(arguments);

  try {
    final appName = PackageReader().readPackageName();
    if (appName != null) {
      var initCommand = InitCommand(appName: appName);
      initCommand.checkActions(parse);
      var scaffoldCommand = ScaffoldCommand(appName: appName);
      scaffoldCommand.checkActions(parse);

      DependenciesWriter().addProjectDependencies();
    }
  } catch (e) {
    print('Got error ${e.toString()}');
  }
//  initCommand.checkActions(parse);
}
