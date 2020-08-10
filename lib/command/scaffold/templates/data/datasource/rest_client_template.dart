import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RestClientTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;

  RestClientTemplate(this.appName, InputModel inputModel,
      {this.featureName = "main"})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase('${inputModel.modelName}_rest_client');
    return rc.snakeCase + '.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/datasource/';
  }

  @override
  String template() {
    final rc = ReCase(inputModel.modelName);

    final t = '''
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/dto/%%SNAKEMODEL%%_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part '%%SNAKEMODEL%%_rest_client.g.dart';

@RestApi()
abstract class %%NAME%%RestClient {
  factory %%NAME%%RestClient(Dio dio, {String baseUrl}) = _%%NAME%%RestClient;

  @GET("/%%NAMECAMEL%%s")
  Future<List<%%NAME%%Dto>> get%%NAME%%s();

  @POST("/%%NAMECAMEL%%s")
  Future<%%NAME%%Dto> post%%NAME%%(@Body() %%NAME%%Dto post);

  @PUT("/%%NAMECAMEL%%s/{id}")
  Future<%%NAME%%Dto> update%%NAME%%(@Path() int id, @Body() %%NAME%%Dto dto);

  @DELETE("/%%NAMECAMEL%%s/{id}")
  Future<void> delete%%NAME%%(@Path() int id);

}

  ''';

    var tt = t.replaceAll('%%NAME%%', rc.pascalCase);
    tt = tt.replaceAll('%%NAMECONSTANT%%', rc.constantCase);
    tt = tt.replaceAll('%%NAMECAMEL%%', rc.camelCase);
    tt = tt.replaceAll("%%APPNAME%%", appName);
    tt = tt.replaceAll("%%FEATURE%%", featureName);
    tt = tt.replaceAll("%%SNAKEMODEL%%", rc.snakeCase);

    return tt;
  }
}
