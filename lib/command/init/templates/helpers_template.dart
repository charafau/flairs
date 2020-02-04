import 'package:flairs/command/simple_file_template.dart';

class HelpersTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'helpers.dart';

  @override
  String get filePath => './core/';

  @override
  String get template => '''
  import 'package:flutter/widgets.dart';
  import 'package:provider/provider.dart';

  /// Import this in other files for not listening providers
  /// import 'package:clean_arch_trivia/core/helpers.dart' as ds;
  T find<T>(BuildContext context) {
    assert(context != null);

    return Provider.of<T>(context, listen: false);
  }

  ///If you want a subtree to be rebuilt anytime the object of type T changes
  /// annotate the region with this widget.
  Widget listen<T>({
    @required WidgetBuilder builder,
  }) {
    return Builder(
      builder: (context) {
        Provider.of<T>(context);
        return builder(context);
      },
    );
  }

  /// Same as the insert method but only used for classes extending ChangeNotifier
  Widget insertNotifier<T extends ChangeNotifier>({
    Key key,
    @required Create<T> create,
    @required Function(BuildContext context, T value) childBuilder,
  }) {
    return ChangeNotifierProvider<T>(
      create: create,
      child: Builder(
        builder: (BuildContext context) {
          return childBuilder(
            context,
            find<T>(context),
          );
        },
      ),
    );

  ''';
}
