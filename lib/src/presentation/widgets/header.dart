import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  final Widget title;

  Header(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: this.title,
      backgroundColor: Colors.red,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
