import 'package:flairs/command/scaffold/scaffold_command.dart';

abstract class ParamFileTemplate {
  final InputModel inputModel;

  ParamFileTemplate(this.inputModel);

  String template();

  String fileName();

  String filePath();
}
