import 'package:flairs/command/simple_file_template.dart';

class InjectorTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'injector.dart';

  @override
  String get filePath => './';

  @override
  String get template {
    return """

    import 'dart:convert';

    import 'package:%%APPNAME%%/core/app_config.dart';
    import 'package:%%APPNAME%%/core/platform/network_info.dart';
    import 'package:%%APPNAME%%/feature_injections.dart';
    import 'package:data_connection_checker/data_connection_checker.dart';
    import 'package:dio/dio.dart';
    import 'package:hive/hive.dart';
    import 'package:provider/single_child_widget.dart';

    Future<List<SingleChildWidget>> initDependencies(AppFlavor appFlavor) async {
      final AppConfig appConfig = AppConfig(appFlavor);
      final Dio dio = Dio();

      dio.interceptors.add(LogInterceptor(responseBody: true));
      if (appConfig.serverPort == null) {
        dio.options.baseUrl =
            "\${appConfig.httpScheme}://\${appConfig.serverLink}/\${appConfig.apiPath}";
      } else {
        dio.options.baseUrl =
            "\${appConfig.httpScheme}://\${appConfig.serverLink}:\${appConfig.serverPort}/\${appConfig.apiPath}";
      }
      dio.transformer = DefaultTransformer(jsonDecodeCallback: (jsonBody) {
        final j = json.decode(jsonBody);
        if (j['data'] != null) {
          return j['data'];
        }
        return j;
      });

      final NetworkInfo networkInfo = NetworkInfoImpl(DataConnectionChecker());

      await Hive.init('/tmp/');

      return injections(dio, networkInfo);
    }

    """;
  }
}
