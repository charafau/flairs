import 'package:flairs/command/simple_file_template.dart';

class BlocTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'simple_bloc_observer.dart';

  @override
  String get filePath => './core/bloc/';

  @override
  String get template => '''
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logMessage(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logMessage(transition.toString());
  }

  @override
  void onError(Cubit bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    logError(error, stacktrace: stacktrace);
  }
}


  ''';
}
