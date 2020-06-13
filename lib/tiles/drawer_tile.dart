import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final iconLeading;
  final iconTrailing;
  final title;
  final Function onTap;

  DrawerTile({this.iconLeading, this.iconTrailing, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        iconLeading,
        color: Colors.white,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      trailing: Icon(
        iconTrailing,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
