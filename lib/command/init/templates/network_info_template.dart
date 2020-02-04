import 'package:flairs/command/simple_file_template.dart';

class NetworkInfoTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'network_info.dart';

  @override
  String get filePath => './core/platform/';

  @override
  String get template => '''
    import 'package:data_connection_checker/data_connection_checker.dart';

    abstract class NetworkInfo {
      Future<bool> get isConnected;
    }

    class NetworkInfoImpl implements NetworkInfo {
      final DataConnectionChecker connectionChecker;

      NetworkInfoImpl(this.connectionChecker);

      @override
      Future<bool> get isConnected => connectionChecker.hasConnection;
    }
  ''';
}
