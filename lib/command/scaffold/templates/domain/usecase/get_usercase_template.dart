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
    rc = ReCase('${inputModel.modelName}_usecases.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './$featureName/domain/usecase/';
  }

  @override
  String template() {
    final temp = """
    import 'package:%%APPNAME%%/core/error/failure.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/number_trivia.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/repository/number_trivia_repository.dart';
    import 'package:dartz/dartz.dart';

    class Get%%NAME%%UseCase {
      final %%NAME%%Repository repository;

      Get%%NAME%%UseCases(this.repository);

      Future<Either<Failure, %%NAME%%>> call(int id) async {
        return await repository.get%%NAME%%(id);
      }
    }

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
