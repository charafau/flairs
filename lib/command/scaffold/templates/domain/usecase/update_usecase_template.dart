import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class UpdateUsecaseTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  UpdateUsecaseTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_usecases.dart';
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
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/post.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/repository/post_repository.dart';
import 'package:dartz/dartz.dart';

class Update%%NAME%%UseCase {
  final %%NAME%%Repository repository;

  Update%%NAME%%UseCase(this.repository);


  Future<Either<Failure, %%NAME%%>> call(%%NAME%% %%NAMECAMEL%%) async => await repository.update%%NAME%%(%%NAMECAMEL%%);

}
    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
