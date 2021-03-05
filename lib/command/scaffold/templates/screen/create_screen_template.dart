import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class CreateScreenTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  CreateScreenTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'create_${rc.snakeCase}_screen.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/screen/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_bloc.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_event.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_state.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/screen/%%SNAKEMODEL%%_form.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';

    class Create%%NAME%%Screen extends StatefulWidget {
      static Route<dynamic> route({Key key}) => MaterialPageRoute(
        builder: (_) => Create%%NAME%%Screen(key: key),
        settings: RouteSettings(name: '/%%NAMECAMEL%%s/new'));

      const Create%%NAME%%Screen({Key key}) : super(key: key);

      @override
      _Create%%NAME%%ScreenState createState() => _Create%%NAME%%ScreenState();
    }

    class _Create%%NAME%%ScreenState extends State<Create%%NAME%%Screen> {
      @override
      Widget build(BuildContext context) {
        return BlocListener<%%NAME%%Bloc, %%NAME%%State>(
          listener: (BuildContext context, state) {
            if (state is %%NAME%%SuccessfullyCreated) {
              Navigator.of(context).pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text('Create %%NAMECAMEL%%'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: %%NAME%%Form(onSave: (%%NAMECAMEL%%) {
                  // ignore: close_sinks
                  final %%NAMECAMEL%%Bloc = context.bloc<%%NAME%%Bloc>();
                  %%NAMECAMEL%%Bloc.add(Add%%NAME%%(%%NAMECAMEL%%));
                }),
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
