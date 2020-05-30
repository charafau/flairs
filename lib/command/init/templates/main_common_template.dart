import 'package:flairs/command/simple_file_template.dart';

class MainCommonTemplate extends SimpleFileTemplate {
  @override
  String get template => '''
import 'package:%%APPNAME%%/core/app_config.dart';
import 'package:%%APPNAME%%/core/bloc/simple_bloc_delegate.dart';
import 'package:%%APPNAME%%/core/screen/start_screen.dart';
import 'package:%%APPNAME%%/injector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:colorize_lumberdash/colorize_lumberdash.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> bootApp(AppFlavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final dependencies = await initDependencies(flavor);
  runApp(_buildRoot(dependencies));
}

Widget _buildRoot(List<SingleChildWidget> providers) {
  return MultiProvider(
    providers: providers,
    child: MaterialApp(
      home: StartScreen(),
    ),
  );
}

''';

  @override
  String get fileName => 'main_common.dart';

  @override
  String get filePath => './';

}