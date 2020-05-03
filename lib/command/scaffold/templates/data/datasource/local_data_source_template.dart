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
    final rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_local_data_source.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/datasource/';
  }

  @override
  String template() {
    final rc = ReCase(inputModel.modelName);

    final template = '''
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/cache/%%SNAKEMODEL%%_cache.dart';
import 'package:hive/hive.dart';

abstract class %%NAME%%LocalDataSource {
  Future<List<%%NAME%%Cache>> get%%NAMECAMEL%%s();

  Future<void> save%%NAMECAMEL%%s(List<%%NAME%%Cache> posts);
}

class %%NAME%%LocalDataSourceImpl extends %%NAME%%LocalDataSource {
  static const String %%NAMECAMEL%%Box = '%%SNAKEMODEL%%';

  @override
  Future<List<%%NAME%%Cache>> get%%NAME%%s() async {
    final box = await _openLocalBox();

    final result = box.get(postBox)?.cast<%%NAME%%Cache>();
    return result ?? [];
  }

  Future<Box> _openLocalBox() async {
    final box = await Hive.openBox('%%NAMESNAKE%%_local_get');
    return box;
  }

  @override
  Future<void> save%%NAMECAMEL%%s(List<%%NAME%%Cache> list) async {
    final box = await _openLocalBox();
    list.forEach((element) async {
      await box.add(element);
    });
  }
}

  ''';

    return replaceTemplates(template, rc, appName, featureName);
  }
}
