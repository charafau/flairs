import 'package:flairs/command/simple_file_template.dart';

class FeatureInjectionsTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'feature_injections.dart';

  @override
  String get filePath => './';

  @override
  String get template {
    return """

    import 'package:dio/dio.dart';
    import 'package:provider/single_child_widget.dart';

    import 'package:%%APPNAME%%/core/platform/network_info.dart';

    List<SingleChildWidget> injections(Dio dio, NetworkInfo networkInfo) {
      return [
//        ...FeatureInjection.injections(dio, networkInfo),
      ];
    }


    """;
  }
}
