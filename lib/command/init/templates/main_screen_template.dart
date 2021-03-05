import 'package:flairs/command/param_file_template.dart';
import 'package:flairs/command/scaffold/scaffold_command.dart';

import 'package:recase/recase.dart';

class MainScreenTemplate extends ParamFileTemplate {
  final String featureName;
  final String appName;
  ReCase? rc;
  MainScreenTemplate(this.appName, InputModel inputModel,
      {this.featureName = 'main'})
      : super(inputModel);

  @override
  String fileName() => 'main_screen.dart';

  @override
  String filePath() {
    return './core/presentation/widget/';
  }

  @override
  String template() {
    final rc = ReCase('${inputModel.modelName}');
    final template = '''
import 'package:%%APPNAME%%/core/platform/contants.dart';
import 'package:%%APPNAME%%/features/%%FEATURE%%/presentation/page/list_post_screen.dart';
import 'package:%%APPNAME%%/features/main/presentation/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, dimens) => Scaffold(
        drawer: dimens.maxWidth <= kDesktopBreakpoint ? AppDrawer(elevation: 0,) : null,
        appBar: dimens.maxWidth <= kTabletBreakpoint ? buildAppBar() : null,
        body: Row(
          children: <Widget>[
            if (dimens.maxWidth >= kDesktopBreakpoint) AppDrawer(elevation: 0),
            Expanded(
                child: Column(
              children: <Widget>[
                if (dimens.maxWidth >= kTabletBreakpoint) buildAppBar(),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: kMaxContentWidth,
                        child: ListPostScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Home',
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}

    ''';

    return replaceTemplates(template, rc, appName, featureName);
  }
}
