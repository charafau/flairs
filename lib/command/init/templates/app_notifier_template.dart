import 'package:flairs/command/simple_file_template.dart';

class AppNotifierTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'app_notifier.dart';

  @override
  String get filePath => './core/notifier/';

  @override
  String get template => '''
  import 'package:flutter/material.dart';

  class AppChangeNotifier extends ChangeNotifier {
    bool _isMounted = true;

    @override
    void dispose() {
      _isMounted = false;
      super.dispose();
    }

    @override
    void notifyListeners() {
      if (_isMounted) {
        super.notifyListeners();
      }
    }
  }
 
  ''';
}
