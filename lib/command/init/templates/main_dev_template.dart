import 'package:flairs/command/simple_file_template.dart';

class MainDevTemplate extends SimpleFileTemplate {
  @override
  String get template => '''
import 'package:%%APPNAME%%/core/app_config.dart';
import 'package:%%APPNAME%%/main_common.dart';

void main() => bootApp(AppFlavor.dev);
''';

  @override
  String get fileName => 'main_dev.dart';

  @override
  String get filePath => './';
}
