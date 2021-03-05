import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RepositoryTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  RepositoryTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_repository.dart';
  }

  @override
  String filePath() {
    return './$featureName/domain/repository/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');
    final temp = """
import 'package:%%APPNAME%%/core/error/failure.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
import 'package:dartz/dartz.dart';

abstract class %%NAME%%Repository {
  Future<Either<Failure, List<%%NAME%%>>> get%%NAME%%s();

  Future<Either<Failure, %%NAME%%>> post%%NAME%%(%%NAME%% %%NAMECAMEL%%);

  Future<Either<Failure, %%NAME%%>> update%%NAME%%(%%NAME%% %%NAMECAMEL%%);

  Future<Either<Failure, bool>> delete%%NAME%%(%%NAME%% %%NAMECAMEL%%);
}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
