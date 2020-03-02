import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class LocalDataSourceTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;

  LocalDataSourceTemplate(this.appName, InputModel inputModel,
      {this.featureName = "main"})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase('${inputModel.modelName}_local_data_source.dart');
    return rc.snakeCase;
  }

  @override
  String filePath() {
    return './main/data/datasource/';
  }

  @override
  String template() {
    final rc = ReCase(inputModel.modelName);

    final t = '''
  import 'dart:convert';

  import 'package:%%APPNAME%%/core/error/exception.dart';
  import 'package:%%APPNAME%%/features/%%FEATURE%%/data/dto/%%SNAKEMODEL%%_dto.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:meta/meta.dart';

  abstract class %%NAME%%LocalDataSource {
    Future<%%NAME%%Dto> getLastNumberTrivia();

    Future<void> cacheNumberTrivia(%%NAME%%Dto %%NAMECAMEL%%);
  }

  const CACHED_%%NAMECONSTANT%% = 'CACHED_%%NAMECONSTANT%%';

  class %%NAME%%DataSourceImpl implements %%NAME%%LocalDataSource {
    final SharedPreferences sharedPreferences;

    %%NAME%%LocalDataSourceImpl({@required this.sharedPreferences});

    @override
    Future<void> cache%%NAME%%(%%NAME%%Dto %%NAMECAMEL%%) {
      return sharedPreferences.setString(
        CACHED_%%NAMECONSTANT%%,
        json.encode(%%NAMECAMEL%%.toJson()),
      );
    }

    @override
    Future<%%NAME%%Dto> getLast%%NAME%%() {
      final jsonString = sharedPreferences.getString(CACHED_%%NAMECONSTANT%%);
      if (jsonString != null) {
        return Future.value(NumberTriviaDto.fromJson(json.decode(jsonString)));
      } else {
        throw CacheException();
      }
    }
  }

  ''';

    var tt = t.replaceAll('%%NAME%%', rc.pascalCase);
    tt = tt.replaceAll('%%NAMECONSTANT%%', rc.constantCase);
    tt = tt.replaceAll('%%NAMECAMEL%%', rc.camelCase);
    tt = tt.replaceAll("%%APPNAME%%", appName);
    tt = tt.replaceAll("%%FEATURE%%", featureName);

    return tt;
  }
}
