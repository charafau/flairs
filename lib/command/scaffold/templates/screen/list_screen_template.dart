import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';
import 'package:recase/recase.dart';

class ListScreenTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  late ReCase rc;

  ListScreenTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() {
    final rc = ReCase(inputModel.modelName);
    return 'list_${rc.snakeCase}_screen.dart';
  }

  @override
  String filePath() {
    return './$featureName/presentation/screen/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');

    final temp = """
    import 'dart:async';

    import 'package:%%APPNAME%%/features/%%FEATURE%%/domain/model/%%SNAKEMODEL%%.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_bloc.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_event.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/bloc/%%SNAKEMODEL%%_state.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/screen/create_%%SNAKEMODEL%%_screen.dart';
    import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/screen/view_%%SNAKEMODEL%%_screen.dart';
    import 'package:flutter/material.dart';
    import 'package:flutter_bloc/flutter_bloc.dart';

    class List%%NAME%%Screen extends StatelessWidget {

      static Route<dynamic> route() {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('%%NAME%% list'),
              ),
              body: create(),
            );
          },
          settings: RouteSettings(name: '/%%NAMECAMEL%%List'),
        );
      }

      static Widget create() {
        return BlocProvider<%%NAME%%Bloc>(
          create: (BuildContext context) => %%NAME%%Bloc.create(context),
          child: %%NAME%%List(),
        );
      }

      @override
      Widget build(BuildContext context) => %%NAME%%List();
    }

    class %%NAME%%List extends StatefulWidget {
      static const %%NAMECAMEL%%ListKey = Key('__%%NAMECAMEL%%List__');

      @override
      _%%NAME%%ListState createState() => _%%NAME%%ListState();
    }

    class _%%NAME%%ListState extends State<%%NAME%%List> {
      Completer<void> _refreshCompleter;

      @override
      void initState() {
        super.initState();
        _refreshCompleter = Completer<void>();
      }

      @override
      Widget build(BuildContext context) {
        // ignore: close_sinks
        final %%NAMECAMEL%%Bloc = context.bloc<%%NAME%%Bloc>();
        return BlocConsumer<%%NAME%%Bloc, %%NAME%%State>(
          builder: (
            BuildContext context,
            %%NAME%%State state,
          ) {
            if (state is %%NAME%%Loading) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: Text('Fetch %%NAMECAMEL%%s'),
                    onPressed: () {
                      %%NAMECAMEL%%Bloc.add(Load%%NAME%%s());
                    },
                  ),
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
            if (state is %%NAME%%sLoaded) {
              return Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      context.bloc<%%NAME%%Bloc>().add(Refresh%%NAME%%s());
                      return _refreshCompleter.future;
                    },
                    child: ListView.builder(
                        key: %%NAME%%List.%%NAMECAMEL%%ListKey,
                        itemCount: state.%%NAMECAMEL%%s.length,
                        itemBuilder: (context, index) {
                          final %%NAMECAMEL%% = state.%%NAMECAMEL%%s[index];
                          return InkWell(
                            onTap: ()  => Navigator.of(context)
                              .push(View%%NAME%%Screen.route(%%NAMECAMEL%%)), 
                            child: _Item(%%NAMECAMEL%%: %%NAMECAMEL%%),
                          );
                        }),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: FloatingActionButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context).push(Create%%NAME%%Screen.route()); 
                      },
                    ),
                  )
                ],
              );
            }

            // if (state is %%NAME%%SuccessfullyCreated) {
            //   return %%NAME%%List(%%NAMECAMEL%%s: state.%%NAMECAMEL%%s);
            // }

            return SizedBox();
          },
          listener: (BuildContext context, %%NAME%%State state) {
            if (state is %%NAME%%Refreshed) {
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
        );
      }
    }

    class _Item extends StatelessWidget {
      const _Item({
        Key key,
        @required this.%%NAMECAMEL%%,
      }) : super(key: key);

      final %%NAME%% %%NAMECAMEL%%;

      @override
      Widget build(BuildContext context) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(child: Text(%%NAMECAMEL%%.toString())),
                IconButton(
                  onPressed: () {
                    // ignore: close_sinks
                    final %%NAMECAMEL%%Bloc = context.bloc<%%NAME%%Bloc>();
                    %%NAMECAMEL%%Bloc.add(Delete%%NAME%%(%%NAMECAMEL%%));
                  },
                  icon: Icon(Icons.delete),
                ),
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
