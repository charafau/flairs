import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class RemoteDataSourceTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;

  RemoteDataSourceTemplate(this.appName, InputModel inputModel,
      {this.featureName = "main"})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_remote_data_source.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/datasource/';
  }

  @override
  String template() {
    final rc = ReCase(inputModel.modelName);

    final template = '''
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/datasource/%%SNAKEMODEL%%_rest_client.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/dto/%%SNAKEMODEL%%_dto.dart';

abstract class %%NAME%%RemoteDataSource {
  Future<List<%%NAME%%Dto>> get%%NAME%%s();

  Future<%%NAME%%Dto> %%NAMECAMEL%%Post(%%NAME%%Dto dto);

  Future<%%NAME%%Dto> updatePost(%%NAME%%Dto dto);

  Future<void> delete%%NAME%%(%%NAME%%Dto dto);
}

class %%NAME%%RemoteDataSourceImpl implements %%NAME%%RemoteDataSource {
  final %%NAME%%RestClient restClient;

  %%NAME%%RemoteDataSourceImpl(this.restClient);

  @override
  Future<List<%%NAME%%Dto>> get%%NAME%%s() async {
    final List<%%NAME%%Dto> response = await restClient.get%%NAME%%s();
    return response;
  }

  @override
  Future<%%NAME%%Dto> post%%NAME%%(%%NAME%%Dto dto) async {
    final result = await restClient.post%%NAME%%(dto);
    return result;
  }

  @override
  Future<%%NAME%%Dto> update%%NAME%%(%%NAME%%Dto dto) async {
    final result = await restClient.update%%NAME%%(dto.id, dto);
    return result;
  }

  @override
  Future<void> delete%%NAME%%(%%NAME%%Dto dto) async => await restClient.delete%%NAME%%(dto.id);
}

  ''';

    return replaceTemplates(template, rc, appName, featureName);
  }
}
