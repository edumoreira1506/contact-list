import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Widget title;
  final List<Widget> actions;

  Header(this.title, this.actions);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: this.title,
      backgroundColor: Colors.red,
      centerTitle: true,
      actions: this.actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
