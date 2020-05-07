import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/presentation/widgets/home/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Contacts extends StatelessWidget {
  final List<ContactDTO> contacts;
  final void Function(BuildContext, int) onTap;

  Contacts(this.contacts, this.onTap);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) => Contact(
        name: this.contacts[index].name,
        image: this.contacts[index].img,
        email: this.contacts[index].email,
        phone: this.contacts[index].phone,
        onTap: () => this.onTap(context, index),
      ),
      itemCount: this.contacts.length,
    );
  }
}
