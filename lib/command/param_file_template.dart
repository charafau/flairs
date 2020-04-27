import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

abstract class ParamFileTemplate {
  final InputModel inputModel;

  ParamFileTemplate(this.inputModel);

  String template();

  String fileName();

  String filePath();

  String replaceTemplates(
      String template, ReCase rc, String appName, String featureName) {
    var tt = template.replaceAll('%%NAME%%', rc.pascalCase);
    tt = tt.replaceAll('%%NAMECONSTANT%%', rc.constantCase);
    tt = tt.replaceAll('%%NAMECAMEL%%', rc.camelCase);
    tt = tt.replaceAll("%%APPNAME%%", appName);
    tt = tt.replaceAll("%%SNAKENAME%%", rc.snakeCase);
    tt = tt.replaceAll("%%SNAKEMODEL%%", rc.snakeCase);
    tt = tt.replaceAll("%%FEATURE%%", featureName);

    return tt;
  }
}
