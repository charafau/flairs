import 'dart:io';

import 'package:args/args.dart';
import 'package:flairs/command/flairs_command.dart';
import 'package:flairs/command/init/templates/app_config_template.dart';
import 'package:flairs/command/init/templates/app_drawer_template.dart';
import 'package:flairs/command/init/templates/app_theme_template.dart';
import 'package:flairs/command/init/templates/bloc_template.dart';
import 'package:flairs/command/init/templates/constants_template.dart';
import 'package:flairs/command/init/templates/exception_template.dart';
import 'package:flairs/command/init/templates/failure_template.dart';
import 'package:flairs/command/init/templates/feature_injections_template.dart';
import 'package:flairs/command/init/templates/helpers_template.dart';
import 'package:flairs/command/init/templates/injector_template.dart';
import 'package:flairs/command/init/templates/main_common_template.dart';
import 'package:flairs/command/init/templates/main_dev_template.dart';
import 'package:flairs/command/init/templates/main_prod_template.dart';
import 'package:flairs/command/init/templates/network_info_template.dart';
import 'package:flairs/command/init/templates/start_screen_template.dart';
import 'package:flairs/command/simple_file_template.dart';
import 'package:flairs/dependencies_writer.dart';

class InitCommand extends FlairsCommand {
  @override
  String get command => 'init';

  @override
  String get usage => '''flair init <directory>''';

  final appName;

  InitCommand({this.appName});

  final List<SimpleFileTemplate> templates = [
    MainDevTemplate(),
    MainProdTemplate(),
    MainCommonTemplate(),
    StartScreenTemplate(),
    InjectorTemplate(),
    FeatureInjectionsTemplate(),
    ConstatntsTemplate(),
    ExceptionTemplate(),
    FailureTempalte(),
    AppConfigTemplate(),
    AppDrawerTemaplte(),
    BlocTemplate(),
    AppThemeTemplate(),
    HelpersTemplate(),
    NetworkInfoTemplate(),
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

      DependenciesWriter().addProjectDependencies();
    } else {
      print(usage);
    }
  }

  void generateFileFromTemplate(SimpleFileTemplate template) {
    final appNamedTemplate =
        template.template.replaceAll('%%APPNAME%%', appName);
    File('lib/${template.filePath}${template.fileName}')
        .create(recursive: true)
        .then((f) {
      f.writeAsString(appNamedTemplate);
    });

    print('Creating file: ${template.filePath}${template.fileName}');
  }

  List<String> coreDirectories = [
    'lib/core/error',
    'lib/core/bloc',
    'lib/core/platform',
    'lib/core/screen',
  ];
}
