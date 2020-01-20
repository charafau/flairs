import 'dart:io';

import 'package:args/args.dart';
import 'package:flair/command/init/templates/app_config_template.dart';
import 'package:flair/command/init/templates/app_notifier_template.dart';
import 'package:flair/command/init/templates/app_theme_template.dart';
import 'package:flair/command/init/templates/exception_template.dart';
import 'package:flair/command/init/templates/failure_template.dart';
import 'package:flair/command/init/templates/helpers_template.dart';
import 'package:flair/command/init/templates/main_dev_template.dart';
import 'package:flair/command/init/templates/main_prod_template.dart';
import 'package:flair/command/init/templates/network_info_template.dart';
import 'package:flair/command/init/templates/result_template.dart';
import 'package:flair/command/init/templates/status_template.dart';
import 'package:flair/command/simple_file_template.dart';

class InitCommand {
  static const String command = 'init';

  static const String usage = '''flair init <directory>''';

  final appName;

  InitCommand({this.appName});

  final List<SimpleFileTemplate> templates = [
//    MainDevTemplate(),
//    MainProdTemplate(),
    ExceptionTemplate(),
    FailureTempalte(),
    AppConfigTemplate(),
    AppNotifierTemplate(),
    AppThemeTemplate(),
    HelpersTemplate(),
    NetworkInfoTemplate(),
    ResultTemplate(),
    StatusTemplate(),
  ];

  void checkActions(ArgResults parser) async {
    final command = parser.command;
    if (command != null &&
        command.name != null &&
        command.name == InitCommand.command &&
        command.arguments != null &&
        command.arguments.length == 1) {
      final outputDis = command.arguments.first;
      await coreDirectories.forEach((dir) async {
        await Directory('$outputDis/$dir').create(recursive: true);
      });
      await templates.forEach(generateFileFromTemplate);
    } else {
      print(usage);
    }
  }

  Future<void> generateFileFromTemplate(SimpleFileTemplate template) async {
    final appNamedTemplate =
        template.template.replaceAll('%%APPNAME%%', appName);
    return File('${template.filePath}${template.fileName}')
        .create(recursive: true)
        .then((f) {
      f.writeAsString(appNamedTemplate);
    });
  }

  List<String> coreDirectories = [
    'core/error',
    'core/notifier',
    'core/platform',
    'core/result',
  ];
}
