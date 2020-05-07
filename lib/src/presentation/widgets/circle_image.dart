import 'dart:io';

import 'package:flutter/widgets.dart';

class CircleImage extends StatelessWidget {
  final String image;
  final bool big;

  CircleImage({ this.image, this.big });
  CircleImage.big({ this.image, this.big = true });
  CircleImage.small({ this.image, this.big = false });

  @override
  Widget build(BuildContext context) {
    return (
      Container(
        width: this.big ? 140 : 80,
        height: this.big ? 140 : 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: this.image != null && this.image != ''
              ? FileImage(File(this.image))
              : AssetImage("assets/images/person.png")
          )
        ),
      )
    );
  }
}
