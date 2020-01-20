import 'package:flair/command/simple_file_template.dart';

class StatusTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'status.dart';

  @override
  String get filePath => './core/result/';

  @override
  String get template => '''
  enum Status { SUCCESS, ERROR, LOADING, RELOADING, RELOAD_SUCCESS }
  ''';
}
