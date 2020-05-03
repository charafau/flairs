import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:flairs/utils/command_utils.dart';
import 'package:recase/recase.dart';

class DtoTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  DtoTemplate(this.appName, InputModel inputModel, {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}_dto.dart';
  }

  @override
  String filePath() {
    return './$featureName/data/dto/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/cache/%%SNAKEMODEL%%_cache.dart';
import 'package:json_annotation/json_annotation.dart';

part '%%SNAKEMODEL%%_dto.g.dart';

@JsonSerializable()
class %%NAME%%Dto {
  %%TYPEDFIELDS%%

  %%NAME%%Dto({%%NAMEDFIELDS%%});

  factory %%NAME%%Dto.fromJson(Map<String, dynamic> json) =>
      _\$%%NAME%%DtoFromJson(json);

  Map<String, dynamic> toJson() => _\$%%NAME%%DtoToJson(this);

  factory %%NAME%%Dto.fromCache(%%NAME%%Cache cache) {
    return %%NAME%%Dto(
      %%FROMCACHEFIELDS%%
    );
  }

  %%NAME%%Cache toCache() {
    return %%NAME%%Cache(
      %%TOCACHEFIELDS%%,
    );
  }
}

    """;

    final typedFields =
        CommandUtils.inputFieldsToClassFields(inputModel.fields);
    var tt = temp.replaceAll(
        '%%TYPEDFIELDS%%', CommandUtils.classFieldsToString(typedFields));
    tt = tt.replaceAll('%%NAMEDFIELDS%%',
        CommandUtils.inputFieldsToNamedParams(inputModel.fields));
    tt = tt.replaceAll(
        '%%TOCACHEFIELDS%%', CommandUtils.copyFields(inputModel.fields));

    tt = tt.replaceAll('%%FROMCACHEFIELDS%%',
        CommandUtils.copyFields(inputModel.fields, from: 'cache'));

    return replaceTemplates(tt, rc, appName, featureName);
  }
}
