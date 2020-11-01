import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class GetUsecaseTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  GetUsecaseTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'get_${rc.snakeCase}s_usecase.dart';
  }

  @override
  String filePath() {
    return './$featureName/domain/usecase/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/core/error/failure.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/repository/%%SNAKEMODEL%%_repository.dart';
import 'package:dartz/dartz.dart';

class Get%%NAME%%sUseCase {
  final %%NAME%%Repository repository;

  Get%%NAME%%sUseCase(this.repository);

  Future<Either<Failure, List<%%NAME%%>>> call() async =>
      await repository.get%%NAME%%s();
}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
