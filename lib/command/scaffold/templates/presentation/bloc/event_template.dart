import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class EventTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;
  EventTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_event.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/bloc/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
import 'package:equatable/equatable.dart';

abstract class %%NAME%%Event extends Equatable {
  const %%NAME%%Event();

  @override
  List<Object> get props => [];
}

class Load%%NAME%%s extends %%NAME%%Event {}

class Add%%NAME%% extends %%NAME%%Event {
  final %%NAME%% %%NAMECAMEL%%;

  Add%%NAME%%(this.%%NAMECAMEL%%);

  @override
  List<Object> get props => [%%NAMECAMEL%%];

  @override
  String toString() => 'Add%%NAME%% { %%NAMECAMEL%%: \$%%NAMECAMEL%% }';
}

class Update%%NAME%% extends %%NAME%%Event {
  final %%NAME%% %%NAMECAMEL%%;

  Update%%NAME%%(this.%%NAMECAMEL%%);

  @override
  List<Object> get props => [%%NAMECAMEL%%];

  @override
  String toString() => 'Updated%%NAME%% { %%NAMECAMEL%%: \$%%NAMECAMEL%% }';
}

class Refresh%%NAME%%s extends %%NAME%%Event {}

class Delete%%NAME%% extends %%NAME%%Event {
  final %%NAME%% %%NAMECAMEL%%;

  Delete%%NAME%%(this.%%NAMECAMEL%%);

  @override
  List<Object> get props => [%%NAMECAMEL%%];

  @override
  String toString() => 'Delete%%NAME%% { %%NAMECAMEL%%: \$%%NAMECAMEL%% }';
}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
