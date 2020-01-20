import 'package:flair/command/simple_file_template.dart';

class ExceptionTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'exception.dart';

  @override
  String get filePath => './core/error/';

  @override
  String get template => '''
  class ServerException implements Exception {}

  class CacheException implements Exception {}
  
  ''';
}
