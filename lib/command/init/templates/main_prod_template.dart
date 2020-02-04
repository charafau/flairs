import 'package:flairs/command/simple_file_template.dart';

class MainProdTemplate extends SimpleFileTemplate {
  @override
  String get template => '''
import 'package:%%APPNAME%%/core/app_config.dart';
import 'package:%%APPNAME%%/main_common.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    // Report to the application zone to report to Crashlytics.
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  await runZoned<Future<void>>(
    () async => bootApp(AppFlavor.prod),
    onError: (Object error, StackTrace stackTrace) async {
      // Whenever an error occurs, call the `reportCrash`
      // to send Dart errors to Crashlytics
      debugPrint(error.toString());
    },
  );
}
''';

  @override
  String get fileName => 'main_prod.dart';

  @override
  String get filePath => './';
}
