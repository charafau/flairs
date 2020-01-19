import 'dart:io';

import 'package:args/args.dart';
import 'package:flair/command/init/templates/main_dev_template.dart';

class InitCommand {
  static const String command = 'init';

  static const String usage = '''flair init <directory>''';

  final appName;

  InitCommand({this.appName});

//  static ArgParser create() => ArgParser();

  void checkActions(ArgResults parser) {
    final command = parser.command;
    if (command != null &&
        command.name != null &&
        command.name == InitCommand.command &&
        command.arguments != null &&
        command.arguments.length == 1) {
      final outputDis = command.arguments.first;
      coreDirectories.forEach((dir) async {
        await Directory('$outputDis/$dir').create(recursive: true);
      });

      var replaceAll = MainDevTemplate.file.replaceAll("%%APPNAME%%", appName);
      print(replaceAll);
      final mainDev = File('./${MainDevTemplate.fileName}').writeAsString(
          replaceAll);

//      Directory(outputDis).create(recursive: true).then((dir) {
//        print(dir.path);
//      });
    } else {
      print(usage);
    }
  }

  List<String> coreDirectories = [
    'core/error',
    'core/notifer',
    'core/platform',
    'core/result',
  ];
}
