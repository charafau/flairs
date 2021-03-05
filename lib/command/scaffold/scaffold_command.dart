import 'dart:io';

import 'package:args/args.dart';
import 'package:flairs/command/flairs_command.dart';
import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/templates/data/cache/cache_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/local_data_source_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/remote_data_source_template.dart';
import 'package:flairs/command/scaffold/templates/data/datasource/rest_client_template.dart';
import 'package:flairs/command/scaffold/templates/data/dto/dto_template.dart';
import 'package:flairs/command/scaffold/templates/data/repository_impl/repository_impl_template.dart';
import 'package:flairs/command/scaffold/templates/domain/model/model_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/delete_usercase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/get_usecase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/post_usecase_template.dart';
import 'package:flairs/command/scaffold/templates/domain/usecase/update_usecase_template.dart';
import 'package:flairs/command/scaffold/templates/presentation/bloc/event_template.dart';
import 'package:flairs/command/scaffold/templates/presentation/bloc/model_bloc_template.dart';
import 'package:flairs/command/scaffold/templates/presentation/bloc/state_template.dart';
import 'package:flairs/command/scaffold/templates/screen/create_screen_template.dart';
import 'package:flairs/command/scaffold/templates/screen/edit_screen_template.dart';
import 'package:flairs/command/scaffold/templates/screen/form_template.dart';
import 'package:flairs/command/scaffold/templates/screen/list_screen_template.dart';
import 'package:flairs/command/scaffold/templates/screen/view_screen_template.dart';

import 'templates/domain/repository/repository_template.dart';

class ScaffoldCommand implements FlairsCommand {
  ScaffoldCommand({required this.appName});

  @override
  String get command => 'scaffold';

  @override
  String get usage => 'flairs scaffold Person id:int name:string age:int';

  final String appName;

  void checkActions(ArgResults parser) async {
    final command = parser.command;
    if (command != null &&
        command.name == this.command &&
        command.arguments.length > 1) {
      if (_hasFeatureSpecified(command)) {
        print('has feature');
      } else {
        print('no feature');
//        _createFutureDirectories('main');

        var inputModel = InputModel.fromCommand(parser);
        print('input model is $inputModel');

        // var localDataSourceTemplate = LocalDataSourceTemplate(inputModel);
        // var localDataSourceTemplate = ModelBlocTemplate(appName, inputModel);
        // print('local: ${localDataSourceTemplate.template()}');
        // print(
        //     '\n\nformatted: \n${formatter.format(localDataSourceTemplate.template())}\n\n');
        // print('name ${localDataSourceTemplate.fileName()}');
        // print('path ${localDataSourceTemplate.filePath()}');
        _createFutureDirectories('main');

        // Data layer
        _createFileFromTemtplate(CacheTemplate(appName, inputModel));
        _createFileFromTemtplate(LocalDataSourceTemplate(appName, inputModel));
        _createFileFromTemtplate(RemoteDataSourceTemplate(appName, inputModel));
        _createFileFromTemtplate(RestClientTemplate(appName, inputModel));
        _createFileFromTemtplate(DtoTemplate(appName, inputModel));
        _createFileFromTemtplate(RepositoryImplTemplate(appName, inputModel));

        // Domain layer
        _createFileFromTemtplate(ModelTemplate(appName, inputModel));
        _createFileFromTemtplate(RepositoryTemplate(appName, inputModel));
        _createFileFromTemtplate(DeleteUsecaseTemplate(appName, inputModel));
        _createFileFromTemtplate(GetUsecaseTemplate(appName, inputModel));
        _createFileFromTemtplate(PostUsecaseTemplate(appName, inputModel));
        _createFileFromTemtplate(UpdateUsecaseTemplate(appName, inputModel));

        // Presentation layer
        _createFileFromTemtplate(EventTemplate(appName, inputModel));
        _createFileFromTemtplate(StateTemplate(appName, inputModel));
        _createFileFromTemtplate(ModelBlocTemplate(appName, inputModel));

        // Screens
        _createFileFromTemtplate(CreateScreenTemplate(appName, inputModel));
        _createFileFromTemtplate(EditScreenTemplate(appName, inputModel));
        _createFileFromTemtplate(FormTemplate(appName, inputModel));
        _createFileFromTemtplate(ListScreenTemplate(appName, inputModel));
        _createFileFromTemtplate(ViewScreenTemplate(appName, inputModel));
      }

      print(
          "Don't forget to run flutter packages run build_runner build --delete-conflicting-outputs");
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
    ];
    final currentDirectory = Directory.current;
    dirs.forEach((dir) {
      Directory('${currentDirectory.path}/lib/features/$dir')
          .createSync(recursive: true);
    });
  }

  void _createFileFromTemtplate(ParamFileTemplate template) {
    File('./lib/features/${template.filePath()}${template.fileName()}')
        .create(recursive: true)
        .then((f) {
      f.writeAsString(template.template());
    });

    print('Creating file: ${template.filePath()}${template.fileName()}');
  }

  bool _hasFeatureSpecified(ArgResults command) {
    return command.arguments.length != command.rest.length;
  }
}

class InputModel {
  late String modelName;

  // name : type
  late Map<String, String> fields;

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
