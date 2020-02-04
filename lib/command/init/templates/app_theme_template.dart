import 'package:flairs/command/simple_file_template.dart';

class AppThemeTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'app_theme.dart';

  @override
  String get filePath => './core/';

  @override
  String get template => '''
  import 'package:flutter/material.dart';

  class AppTheme {
    AppTheme()
        : data = ThemeData(
            accentColor: Colors.pinkAccent,
            primaryColor: Colors.indigo,
            brightness: Brightness.light,
          );

    final ThemeData data;
  }
 
  ''';
}
