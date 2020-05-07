import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Contact extends StatelessWidget {
  final String name;
  final String image;
  final String phone;
  final String email;

  Contact({
    this.name,
    this.image,
    this.phone,
    this.email
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: this.image != null && this.image != ''
                      ? FileImage(File(this.image))
                      : AssetImage("assets/images/person.png")
                  )
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      this.name ?? '',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      this.email ?? '',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    Text(
                      this.phone ?? '',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
