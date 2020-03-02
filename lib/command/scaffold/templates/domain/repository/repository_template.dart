import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RepositoryTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;

  RepositoryTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase('${inputModel.modelName}_repository.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './$featureName/domain/repository/';
  }


  @override
  String template() {
    // TODO: implement template
    return null;
  }
}
