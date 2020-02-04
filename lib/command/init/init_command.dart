import 'dart:io';

import 'package:args/args.dart';
import 'package:flairs/command/flairs_command.dart';
import 'package:flairs/command/init/templates/app_config_template.dart';
import 'package:flairs/command/init/templates/app_notifier_template.dart';
import 'package:flairs/command/init/templates/app_theme_template.dart';
import 'package:flairs/command/init/templates/exception_template.dart';
import 'package:flairs/command/init/templates/failure_template.dart';
import 'package:flairs/command/init/templates/helpers_template.dart';
import 'package:flairs/command/init/templates/network_info_template.dart';
import 'package:flairs/command/init/templates/result_template.dart';
import 'package:flairs/command/init/templates/status_template.dart';
import 'package:flairs/command/simple_file_template.dart';

class InitCommand extends FlairsCommand {
  @override
  String get command => 'init';

  @override
  String get usage => '''flair init <directory>''';

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
        command.name == this.command &&
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
