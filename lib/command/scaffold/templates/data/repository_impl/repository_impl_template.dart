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
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_repository_impl.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/repository_impl/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final template = '''
import 'package:%%APPNAME%%core/error/exception.dart';
import 'package:%%APPNAME%%/core/error/failure.dart';
import 'package:%%APPNAME%%/core/platform/network_info.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/cache/%%SNAKENAME%%_cache.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/datasource/%%SNAKENAME%%_local_data_source.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/datasource/%%SNAKENAME%%_remote_data_source.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/dto/%%SNAKENAME%%_dto.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKENAME%%.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/repository/%%SNAKENAME%%_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class %%NAME%%RepositoryImpl implements %%NAME%%Repository {
  final %%NAME%%LocalDataSource localDataSource;
  final %%NAME%%RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  %%NAME%%RepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<%%NAME%%>>> get%%NAME%%s() async {
    if (await networkInfo.isConnected) {
      try {
        final List<%%NAME%%Dto> %%NAMECAMEL%%Dto = await remoteDataSource.get%%NAME%%s();

        localDataSource
            .save%%NAME%%s(%%NAMECAMEL%%sDto.map((dto) => dto.toCache()).toList());

        return Right(%%NAMECAMEL%%sDto.map((d) => %%NAME%%.fromDto(d)).toList());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final List<%%NAME%%Cache> %%NAMECAMEL%%sCached = await localDataSource.get%%NAME%%s();
        return Right(%%NAMECAMEL%%sCached.map((c) => %%NAME%%.fromCache(c)).toList());
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  Future<Either<Failure, %%NAME%%>> post%%NAME%%(%%NAME%% %%NAMECAMEL%%) async {
    try {
      final %%NAME%%Dto result = await remoteDataSource.post%%NAME%%(%%NAMECAMEL%%.toDto());

      return Right(%%NAME%%.fromDto(result));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, %%NAME%%>> update%%NAME%%(%%NAME%% %%NAMECAMEL%%) async {
    try {
      final %%NAME%%Dto result = await remoteDataSource.update%%NAME%%(%%NAMECAMEL%%.toDto());

      return Right(%%NAME%%.fromDto(result));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> delete%%NAME%%(%%NAME%% %%NAMECAMEL%%) async {
    try {
      await remoteDataSource.delete%%NAME%%(%%NAMECAMEL%%.toDto());

      return Right(true);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}

    ''';

    return replaceTemplates(template, rc, appName, featureName);
  }
}
