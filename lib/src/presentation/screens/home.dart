import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/model/service/contact_service.dart';
import 'package:contact_list/src/presentation/screens/contact.dart';
import 'package:contact_list/src/presentation/widgets/header.dart';
import 'package:contact_list/src/presentation/widgets/home/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactDTO> _contacts = List();
  ContactService _service = ContactService();

  @override
  void initState() {
    super.initState();

    _findContacts();
  }

  void _findContacts() async {
    List<ContactDTO> list = await _service.all();

    setState(() {
      _contacts = list;
    });
  }

  void _handleSave(ContactDTO contact) async {
    if (contact != null) {
      if (contact.id != null) _service.update(contact);
      else _service.save(contact);
    }

    setState(() {
      _findContacts();
    });
  }

  void _handleChangeContactPage({ ContactDTO contact }) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => 
          ContactPage(
            contact: contact,
            onSave: _handleSave,
          )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        Text('Contacts')
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _handleChangeContactPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: Contacts(
        _contacts,
        (ContactDTO dto) => _handleChangeContactPage(contact: dto)
      )
    );
  }
}