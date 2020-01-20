import 'package:flair/command/simple_file_template.dart';

class ResultTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'result.dart';

  @override
  String get filePath => './core/result/';

  @override
  String get template => '''
  import 'package:%%APPNAME%%/core/result/status.dart';

  class Result<T> {
    final Status status;
    final T data;
    final String message;

    Result._(this.status, [this.data, this.message]);

    factory Result.loading({T data, String message}) {
      return Result<T>._(Status.LOADING, data, message);
    }

    factory Result.success({T data, String message}) {
      return Result<T>._(Status.SUCCESS, data, message);
    }

    factory Result.error({T data, String message}) {
      return Result<T>._(Status.ERROR, data, message);
    }

    factory Result.from(Status status, {T data, String message}) {
      return Result<T>._(status, data, message);
    }

    bool get isSuccessful => status == Status.SUCCESS;

    bool get isNotSuccessful => status != Status.SUCCESS;

    bool get isLoading => status == Status.LOADING;

    @override
    String toString() {
      return 'Result{status: \$status, data: \$data, message: \$message}';
    }

    @override
    bool operator ==(Object other) =>
        identical(this, other) ||
        other is Result &&
            runtimeType == other.runtimeType &&
            status == other.status &&
            data == other.data &&
            message == other.message;

    @override
    int get hashCode => status.hashCode ^ data.hashCode ^ message.hashCode;
  }
 
  ''';

}