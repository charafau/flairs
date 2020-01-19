class MainDevTemplate {
  static const String file = '''
import 'package:%%APPNAME%%/core/app_config.dart';
import 'package:%%APPNAME%%/main_common.dart';

void main() => bootApp(AppFlavor.dev);
''';

  static String fileName = 'main_dev.dart';
}
