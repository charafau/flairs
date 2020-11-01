import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class StateTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;
  StateTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_state.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/bloc/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%NAMECAMEL%%.dart';
import 'package:equatable/equatable.dart';

abstract class %%NAME%%State extends Equatable {
  const %%NAME%%State();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class %%NAME%%Loading extends %%NAME%%State {}

class %%NAME%%sLoaded extends %%NAME%%State {
  final List<%%NAME%%> %%NAMECAMEL%%s;

  %%NAME%%sLoaded(this.%%NAMECAMEL%%s);

  @override
  List<Object> get props => [%%NAMECAMEL%%s];
}

class %%NAME%%sNotLoaded extends %%NAME%%State {}

class %%NAME%%NotCreated extends %%NAME%%State {}

class %%NAME%%SuccessfullyCreated extends %%NAME%%State {
  final List<%%NAME%%> %%NAMECAMEL%%s;
  final int addedItemIndex;

  %%NAME%%SuccessfullyCreated(this.%%NAMECAMEL%%s, this.addedItemIndex);

  @override
  List<Object> get props => [%%NAMECAMEL%%s, addedItemIndex];
}

class %%NAME%%SuccessfullyUpdated extends %%NAME%%State {
  final %%NAME%% %%NAMECAMEL%%;

  %%NAME%%SuccessfullyUpdated(this.%%NAMECAMEL%%);

  @override
  List<Object> get props => [%%NAMECAMEL%%];
}

class %%NAME%%EditFailed extends %%NAME%%State {}

class %%NAME%%DeleteFailed extends %%NAME%%State {}

class %%NAME%%DeletedSuccessfylly extends %%NAME%%State {}

class %%NAME%%Refreshed extends %%NAME%%State {}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
