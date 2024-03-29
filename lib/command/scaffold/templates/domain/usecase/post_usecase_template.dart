import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class PostUsecaseTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  PostUsecaseTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'post_${rc.snakeCase}_usecase.dart';
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

class Post%%NAME%%UseCase {
  final %%NAME%%Repository repository;

  Post%%NAME%%UseCase(this.repository);


  Future<Either<Failure, %%NAME%%>> call(%%NAME%% %%NAMECAMEL%%) async => await repository.post%%NAME%%(%%NAMECAMEL%%);
}
    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
