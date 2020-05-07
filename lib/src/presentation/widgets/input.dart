import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType type;

  Input({ this.label, this.controller, this.type });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: this.label
      ),
      controller: this.controller,
      keyboardType: this.type,
    );
  }
}
