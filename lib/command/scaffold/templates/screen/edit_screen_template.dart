import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class EditScreenTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase rc;

  EditScreenTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'edit_${rc.snakeCase}_screen.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/screen/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_bloc.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_event.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/page/%%SNAKEMODEL%%_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Edit%%NAME%%Screen extends StatefulWidget {

    static Route<dynamic> route(%%NAME%% %%NAMECAMEL%%, {Key key}) => MaterialPageRoute(
      builder: (_) => EditPostScreen(%%NAMECAMEL%%: %%NAMECAMEL%%, key: key),
      settings: RouteSettings(name: '/%%NAMECAMEL%%s/edit'));

  final %%NAME%% %%NAMECAMEL%%;

  const Edit%%NAME%%Screen({Key key, @required this.%%NAMECAMEL%%}) : super(key: key);

  @override
  _Edit%%NAME%%ScreenState createState() => _Edit%%NAME%%ScreenState();
}

class _Edit%%NAME%%ScreenState extends State<Edit%%NAME%%Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit %%NAMECAMEL%%'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: %%NAME%%Form(
            %%NAMECAMEL%%: widget.%%NAMECAMEL%%,
            onSave: (%%NAMECAMEL%%) {
              // ignore: close_sinks
              final %%NAMECAMEL%%Bloc = context.bloc<%%NAME%%Bloc>();
              %%NAMECAMEL%%Bloc.add(Update%%NAME%%(%%NAMECAMEL%%));
            },
          ),
        ),
      ),
    );
  }
}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
