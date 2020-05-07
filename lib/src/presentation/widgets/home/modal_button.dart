import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ModalButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  ModalButton(this.onTap, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: FlatButton(
        child: Text(
          this.text,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20
          )
        ),
        onPressed: this.onTap,
      ),
    );
  }
}
