import 'package:flairs/command/simple_file_template.dart';

class AppConfigTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'app_config.dart';

  @override
  String get filePath => './core/';

  @override
  String get template => '''
  enum AppFlavor { prod, dev, local }

  abstract class AppConfig {
    const AppConfig._();

    String get apiLink => "";

    AppFlavor get flavor;

    factory AppConfig(AppFlavor flavor) {
      switch (flavor) {
        case AppFlavor.prod:
          return const _ProdConfig();
        case AppFlavor.dev:
          return const _DevConfig();
        case AppFlavor.local:
          return const _LocalConfig();
      }

      throw '\$flavor is not a recognised app flavor value';
    }
  }

  class _ProdConfig extends AppConfig {
    const _ProdConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.prod;
  }

  class _DevConfig extends AppConfig {
    const _DevConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.dev;
  }

  class _LocalConfig extends AppConfig {
    const _LocalConfig() : super._();

    @override
    AppFlavor get flavor => AppFlavor.local;
  }
 
  ''';
}
