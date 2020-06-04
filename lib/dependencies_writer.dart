import 'dart:io';

import 'package:yaml/yaml.dart';

const String sampleYaml = '''

name: flairs
description: A sample command-line application.
# version: 1.0.0
# homepage: https://www.example.com

environment:
  sdk: '>=2.7.0 <3.0.0'

dependencies:
  args: ^1.5.2
  yaml: ^2.2.0
  recase: ^3.0.0
  dart_style: ^1.3.6
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.

#  path: ^1.6.0

dev_dependencies:
  dartx:
  sqlite:
  hive_generator: ^0.7.0+2
  flutter_test:
    sdk: flutter

''';

class DependenciesWriter {
  final List<String> projectDeps = [
    'equatable',
    'flutter_bloc',
    'dartz',
    'http',
    'dio',
    'shared_preferences',
    'retrofit',
    'lumberdash',
    'colorize_lumberdash',
    'bloc',
    'data_connection_checker',
    'json_serializable',
    'provider',
    'rxdart',
    'hive',
    'hive_flutter',
  ];

  final List<String> projectDevDeps = [
    'retrofit_generator',
    'build_runner',
    'mockito',
    'hive_generator',
  ];

  String addProjectDependencies() {
    // final file = File('./pubspec.yaml');
    // final stringPubspec = file.readAsStringSync();
    // final pubspec = loadYaml(stringPubspec);
    final pubspec = loadYaml(sampleYaml);
    if (pubspec == null) {
      throw FileSystemException("Could not load file");
    }

    final YamlMap depMap = pubspec['dependencies'];

    final YamlMap devDepMap = pubspec['dev_dependencies'];

    final updatedDeps = <String, String>{};

    final updatedDevDeps = <String, String>{};

    depMap.forEach((key, value) {
      if (key != null && key != 'flutter') {
        updatedDeps.putIfAbsent(key, () => value ?? '');
      }
    });

    devDepMap.forEach((key, value) {
      if (key != null && key != 'flutter_test') {
        print('current val $value');
        updatedDevDeps.putIfAbsent(key, () => value ?? '');
      }
    });

    projectDeps.forEach((element) {
      updatedDeps.putIfAbsent(element, () => '');
    });

    projectDevDeps.forEach((element) {
      updatedDevDeps.putIfAbsent(element, () => '');
    });

    print('deps: \n\n');
    print(updatedDeps);

    print('\n\ndev deps: \n\n');
    print(updatedDevDeps);

    final deps = _createDependeciesBlock(updatedDeps);
    final devDeps = _createDevDependenciesBlock(updatedDevDeps);

    print(deps);
    print('\n\n');
    print(devDeps);
  }

  String _createDependeciesBlock(Map<String, String> updatedDevDeps){
    var devDeps = "dependencies:\n";

    updatedDevDeps.forEach((key, value) {
      devDeps = devDeps + "  $key: $value\n";
    });

    devDeps = devDeps + "  flutter:\n";
    devDeps = devDeps + "    sdk: flutter\n";
    return devDeps;
  }

  String _createDevDependenciesBlock(Map<String, String> updatedDevDeps) {
    var devDeps = "dev_dependencies:\n";

    updatedDevDeps.forEach((key, value) {
      devDeps = devDeps + "  $key: $value\n";
    });

    devDeps = devDeps + "  flutter_test:\n";
    devDeps = devDeps + "    sdk: flutter\n";
    return devDeps;
  }
}
