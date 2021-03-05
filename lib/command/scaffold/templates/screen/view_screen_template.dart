import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class ViewScreenTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  ViewScreenTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'view_${rc.snakeCase}_screen.dart';
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
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_state.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/screen/edit_%%SNAKEMODEL%%_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class View%%NAME%%Screen extends StatefulWidget {

  static Route<dynamic> route(%%NAME%% %%NAMECAMEL%%, {Key key}) => MaterialPageRoute(
        builder: (_) => View%%NAME%%Screen(%%NAMECAMEL%%: %%NAMECAMEL%%, key: key),
        settings: RouteSettings(name: '/%%NAMECAMEL%%s/view'),
      );

  final %%NAME%% %%NAMECAMEL%%;

  const View%%NAME%%Screen({Key key, this.%%NAMECAMEL%%}) : super(key: key);

  @override
  _View%%NAME%%ScreenState createState() => _View%%NAME%%ScreenState();
}

class _View%%NAME%%ScreenState extends State<View%%NAME%%Screen> {
  %%NAME%% _local%%NAME%%;

  @override
  void initState() {
    super.initState();
    _local%%NAME%% = widget.%%NAMECAMEL%%;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<%%NAME%%Bloc, %%NAME%%State>(
      listener: (BuildContext context, %%NAME%%State state) {
        if (state is %%NAME%%SuccessfullyUpdated) {
          _local%%NAME%% = state.%%NAMECAMEL%%;
          setState(() {});
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('%%NAME%%'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Edit%%NAME%%Screen(
                    %%NAMECAMEL%%: _local%%NAME%%,
                  );
                }));
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('id'),
                  ),
                  Flexible(child: Text('\${_local.id}'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('title'),
                  ),
                  Flexible(child: Text('\${_local%%NAME%%.title}'))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('body'),
                  ),
                  Flexible(child: Text('\${_local%%NAME%%.body}'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

    """;

    return replaceTemplates(temp, rc, appName, featureName);
  }
}
