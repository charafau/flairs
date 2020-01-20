import 'package:flair/command/simple_file_template.dart';

class FailureTempalte extends SimpleFileTemplate {
  @override
  String get fileName => 'failure.dart';

  @override
  String get filePath => './core/error/';

  @override
  String get template => '''
  import 'package:equatable/equatable.dart';

  abstract class Failure extends Equatable {
    @override
    List<Object> get props => null;
  }

  class ServerFailure extends Failure {}

  class CacheFailure extends Failure {} 
  ''';
}
