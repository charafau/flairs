import 'dart:io';

import 'package:args/args.dart';
import 'package:flairs/command/flairs_command.dart';

class ScaffoldCommand implements FlairsCommand {
  ScaffoldCommand({this.appName});

  @override
  String get command => 'scaffold';

  @override
  String get usage => 'flairs scaffold Person name:string age:int';

  final String appName;

  void checkActions(ArgResults parser) async {
    final command = parser.command;
    if (command != null &&
        command.name == this.command &&
        command.arguments != null &&
        command.arguments.length > 1) {
      print('got it');
      if (_hasFeatureSpecified(command)) {
        print('has feature');
      } else {
        print('no feature');
        _createFutureDirectories('main');
      }
    } else {
      print(usage);
    }
  }

  void _createFutureDirectories(String featureName) {
    final dirs = [
      '$featureName/data',
      '$featureName/data/datasource',
      '$featureName/data/dto',
      '$featureName/data/repository_impl',
      '$featureName/domain',
      '$featureName/domain/model',
      '$featureName/domain/repository',
      '$featureName/domain/usecase',
      '$featureName/presentation',
      '$featureName/presentation/notifier',
      '$featureName/presentation/page',
      '$featureName/presentation/widget',
    ];
    final currentDirectory = Directory.current;
    dirs.forEach((dir) {
      Directory('${currentDirectory.path}/$dir').createSync(recursive: true);
    });
  }

  bool _hasFeatureSpecified(ArgResults command) {
    return command.arguments.length != command.rest.length;
  }
}
