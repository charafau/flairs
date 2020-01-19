import 'dart:io';

import 'package:yaml/yaml.dart';

class PackageReader {
  String readPackageName() {
    final file = File('./pubspec.yaml');
    final stringPubspec = file.readAsStringSync();
    final pubspec = loadYaml(stringPubspec);
    if (pubspec != null) {
      return pubspec['name'];
    }
    return null;
  }
}
