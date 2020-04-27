import 'package:flairs/command/simple_file_template.dart';

class AppDrawerTemaplte extends SimpleFileTemplate {
  @override
  String get fileName => 'app_drawer.dart';

  @override
  String get filePath => './core/presentation/widget/';

  @override
  String get template => '''
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final double elevation;
  final int hoveredIndex;

  const AppDrawer({Key key, this.elevation, this.hoveredIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: elevation,
      child: Container(
        color: Colors.blueGrey.shade700,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('hello@example.com'),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(child: FlutterLogo(),),
                decoration: BoxDecoration(color: Colors.blueGrey.shade900),
                otherAccountsPictures: <Widget>[],
                arrowColor: Colors.white,
              ),
              _MenuTile(index: 0, icon: Icons.home, name: 'Home'),
              _MenuTile(index: 1, icon: Icons.inbox, name: 'Inbox'),
              _MenuTile(index: 2, icon: Icons.delete, name: 'Trash'),
              _MenuTile(index: 3, icon: Icons.info, name: 'Spam'),
              _MenuTile(index: 4, icon: Icons.chat, name: 'Forums'),
              _MenuTile(index: 5, icon: Icons.flag, name: 'Updates'),
              _MenuTile(index: 6, icon: Icons.label, name: 'Promos'),
              _MenuTile(index: 7, icon: Icons.shopping_cart, name: 'Purchases'),
              _MenuTile(index: 8, icon: Icons.people, name: 'Social'),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final int index;
  final IconData icon;
  final String name;
  final bool isHovered;

  const _MenuTile({
    Key key,
    this.index,
    this.icon,
    this.name,
    this.isHovered = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor =
    isHovered ? Colors.grey.shade600 : Colors.blueGrey.shade300;
    final textColor =
    isHovered ? Colors.grey.shade800 : Colors.blueGrey.shade200;
    return MouseRegion(
      child: Container(
        color: isHovered ? Color(0xFF4BA1B5) : null,
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(
            name,
            style: TextStyle(color: textColor),
          ),
          onTap: () {
            Navigator.maybePop(context);
          },
        ),
      ),
    );
  }
}

  ''';
}
