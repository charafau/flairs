import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RepositoryImplTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;

  RepositoryImplTemplate(this.appName, InputModel inputModel,
      {this.featureName = "main"})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase('${inputModel.modelName}_repository_impl.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './main/data/repository_impl/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final template = """
    import 'package:%%APPNAME%%/core/error/exception.dart';
    import 'package:%%APPNAME%%/core/error/failure.dart';
    import 'package:%%APPNAME%%/core/platform/network_info.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/data/datasource/%%SNAKEMODEL%%_local_data_source.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/data/datasource/%%SNAKEMODEL%%_remote_data_source.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/repository/%%SNAKEMODEL%%_repository.dart';
    import 'package:dartz/dartz.dart';
    import 'package:meta/meta.dart';

    class %%NAME%%RepositoryImpl implements %%NAME%%Repository {
      final %%NAME%%RemoteDataSource remoteDataSource;
      final %%NAME%%LocalDataSource localDataSource;
      final NetworkInfo networkInfo;

      %%NAME%%RepositoryImpl({
        @required this.remoteDataSource,
        @required this.localDataSource,
        @required this.networkInfo,
      });

      @override
      Future<Either<Failure, %%NAME%%>> getConcrete%%NAME%%(
          int number) async {
        networkInfo.isConnected;
        if (await networkInfo.isConnected) {
          try {
            final dto = await remoteDataSource.getConcrete%%NAME%%(number);

            localDataSource.cache%%NAME%%(dto);
            return Right(%%NAME%%(text: dto.text, number: dto.number));
          } on ServerException {
            return Left(ServerFailure());
          }
        } else {
          try {
            final dto = await localDataSource.getLast%%NAME%%();
            return Right(%%NAME%%(text: dto.text, number: dto.number));
          } on CacheException {
            return Left(CacheFailure());
          }
        }
      }

      @override
      Future<Either<Failure, %%NAME%%>> getRandom%%NAME%%() async {
        networkInfo.isConnected;
        if (await networkInfo.isConnected) {
          try {
            final dto = await remoteDataSource.getRandom%%NAME%%();

            localDataSource.cache%%NAME%%(dto);
            return Right(%%NAME%%(text: dto.text, number: dto.number));
          } on ServerException {
            return Left(ServerFailure());
          }
        } else {
          try {
            final dto = await localDataSource.getLast%%NAME%%();
            return Right(%%NAME%%(text: dto.text, number: dto.number));
          } on CacheException {
            return Left(CacheFailure());
          }
        }
      }
    }

    """;

    var output = template.replaceAll("%%NAME%%", rc.pascalCase);
    output = output.replaceAll("%%SNAKEMODEL%%", rc.snakeCase);

    output = output.replaceAll("%%APPNAME%%", appName);
    output = output.replaceAll("%%FEATURE%%", featureName);
    return output;
  }
}
