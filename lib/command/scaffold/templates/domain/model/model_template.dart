import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:flairs/utils/command_utils.dart';
import 'package:recase/recase.dart';

class ModelTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  ModelTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    rc = ReCase(inputModel.modelName);
    return '${rc.snakeCase}.dart';
  }

  @override
  String filePath() {
    return './$featureName/domain/model/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/cache/%%SNAKEMODEL%%_cache.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/data/dto/%%SNAKEMODEL%%_dto.dart';
import 'package:equatable/equatable.dart';

class %%NAME%% extends Equatable {
  
  %%TYPEDFIELDS%%

  %%NAME%%({%%NAMEDFIELDS%%});

  @override
  List<Object> get props => [%%FIELDNAMES%%];

  @override
  bool get stringify => true;

  factory %%NAME%%.fromDto(%%NAME%%Dto dto) {
    return %%NAME%%(
      %%FROMDTOFIELDS%%
    );
  }

  %%NAME%%Dto toDto() {
    return %%NAME%%Dto(
      %%TODTOFIELDS%%
    );
  }

  %%NAME%% copy({%%COPYFIELDS%%}) {
    return %%NAME%%(
      %%COPYLOGICFIELDS%%
    );
  }

  factory %%NAME%%.fromCache(%%NAME%%Cache cache) {
    return %%NAME%%(
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

    tt = tt.replaceAll(
        '%%TOSTRINGFIELDS%%', CommandUtils.toStringFields(inputModel.fields));

    tt = tt.replaceAll('%%FIELDNAMES%%', inputModel.fields.keys.join(', '));

    tt = tt.replaceAll(
        '%%FIELDNAMES%%', CommandUtils.toStringFields(inputModel.fields));

    tt = tt.replaceAll('%%FROMDTOFIELDS%%',
        CommandUtils.copyFields(inputModel.fields, from: 'dto'));

    tt = tt.replaceAll(
        '%%TODTOFIELDS%%', CommandUtils.copyFields(inputModel.fields));

    final copyFields = CommandUtils.inputFieldsToCopyFields(inputModel.fields,
        declimeter: ',');
    tt = tt.replaceAll('%%COPYFIELDS%%',
        CommandUtils.classFieldsToString(copyFields, joinChar: ''));

    tt = tt.replaceAll(
        '%%COPYLOGICFIELDS%%', CommandUtils.copyFieldsLogic(inputModel.fields));

    return replaceTemplates(tt, rc, appName, featureName);
  }
}
