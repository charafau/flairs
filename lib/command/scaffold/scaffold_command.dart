import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_style/dart_style.dart';
import 'package:flairs/command/flairs_command.dart';
import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/local_data_source_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/remote_data_source_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/rest_client_template.dart';
import 'package:flairs/command/scaffold/templates/data/dto/dto_template.dart';
import 'package:flairs/command/scaffold/templates/data/repository_impl/repository_impl_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/delete_usercase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/get_usecase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/post_usecase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/update_usecase_template.dart';

import 'templates/domain/repository/repository_template.dart';

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
      final formatter = DartFormatter();
      if (_hasFeatureSpecified(command)) {
        print('has feature');
      } else {
        print('no feature');
//        _createFutureDirectories('main');

        var inputModel = InputModel.fromCommand(parser);
        print('input model is $inputModel');

        // var localDataSourceTemplate = LocalDataSourceTemplate(inputModel);
        var localDataSourceTemplate = DtoTemplate(appName, inputModel);
        // print('local: ${localDataSourceTemplate.template()}');
        print('\n\nformatted: \n${formatter.format(localDataSourceTemplate.template())}\n\n');
        print('name ${localDataSourceTemplate.fileName()}');
        print('path ${localDataSourceTemplate.filePath()}');
        // _createFutureDirectories('main');
        // _createFileFromTemtplate(RemoteDataSourceTemplate(appName, inputModel));
        // _createFileFromTemtplate(LocalDataSourceTemplate(appName, inputModel));
        // _createFileFromTemtplate(RepositoryImplTemplate(appName, inputModel));
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

  void _createFileFromTemtplate(ParamFileTemplate template) {
    File('${template.filePath()}${template.fileName()}')
        .create(recursive: true)
        .then((f) {
      f.writeAsString(template.template());
    });
  }

  bool _hasFeatureSpecified(ArgResults command) {
    return command.arguments.length != command.rest.length;
  }
}

class InputModel {
  String modelName;

  Map<String, String> fields;

  InputModel.fromCommand(ArgResults argResults) {
    final args = argResults.arguments;
    print('args are $args');
    modelName = args[1];
    fields = {};

    final argsFields = args.sublist(2);
    argsFields.forEach((f) {
      final field = f.split(':');
      if (field.length == 2 && types.contains(field[1])) {
        fields.putIfAbsent(field[0], () => field[1]);
      }
    });
  }

  @override
  String toString() {
    return 'InputModel{modelName: $modelName, fields: $fields}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InputModel &&
          runtimeType == other.runtimeType &&
          modelName == other.modelName &&
          fields == other.fields;

  @override
  int get hashCode => modelName.hashCode ^ fields.hashCode;

  static final List<String> types = ['string', 'int', 'double', 'bool'];
}
