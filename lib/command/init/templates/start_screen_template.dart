
import 'package:flairs/command/simple_file_template.dart';

class StartScreenTemplate extends SimpleFileTemplate {
  @override
  String get fileName => 'start_screen.dart';

  @override
  String get filePath => './core/screen';

  @override
  String get template {

    return """
    import 'package:%%APPNAME%%/core/platform/contants.dart';
    import 'package:%%APPNAME%%/features/main/presentation/widget/app_drawer.dart';
    import 'package:flutter/material.dart';

    class StartScreen extends StatelessWidget {
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
                            child: Center(child: Text('Welcome to flairs!')),
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

    """;
  }

}