import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:flairs/utils/command_utils.dart';
import 'package:recase/recase.dart';

class CacheTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  CacheTemplate(this.appName, InputModel inputModel, {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_cache.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/cache/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:hive/hive.dart';

part '%%SNAKEMODEL%%_cache.g.dart';

@HiveType(typeId: %%HIVECLASSTYPE%%)
class %%NAME%%Cache extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String body;

  %%HIVETYPEDFIELDS%%

  %%NAME%%Cache({%%NAMEDFIELDS%%});

  @override
  String toString() {
    return '%%NAME%%Cache{%%TOSTRINGFIELDS%%}';
  }
}

    """;

    final typedFields =
        CommandUtils.inputFieldsToHiveClassFields(inputModel.fields);
    var tt = temp.replaceAll(
        '%%HIVETYPEDFIELDS%%', CommandUtils.classFieldsToString(typedFields));
    tt = tt.replaceAll('%%NAMEDFIELDS%%',
        CommandUtils.inputFieldsToNamedParams(inputModel.fields));

    tt = tt.replaceAll(
        '%%TOSTRINGFIELDS%%', CommandUtils.toStringFields(inputModel.fields));
    tt = tt.replaceAll('%%HIVECLASSTYPE%%', '0');

    return replaceTemplates(tt, rc, appName, featureName);
  }
}
