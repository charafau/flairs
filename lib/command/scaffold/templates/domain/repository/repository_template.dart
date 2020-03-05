import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RepositoryTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  RepositoryTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    rc = ReCase('${inputModel.modelName}_repository.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './$featureName/domain/repository/';
  }

  @override
  String template() {
    final temp = """
    import 'package:%%APPNAME%%/core/error/failure.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/number_trivia.dart';
    import 'package:dartz/dartz.dart';

    abstract class %%NAME%%Repository {
      Future<Either<Failure, %%NAME%%>> get%%NAME%%(int id);
    }

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
