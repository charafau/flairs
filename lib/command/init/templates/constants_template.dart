import 'package:flairs/command/simple_file_template.dart';

class ConstatntsTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'constants.dart';

  @override
  String get filePath => './core/platform/';

  @override
  String get template => '''
const kTabletBreakpoint = 720.0;
const kDesktopBreakpoint = 1220.0;
const kMaxContentWidth = 1070.0;
  ''';
}
