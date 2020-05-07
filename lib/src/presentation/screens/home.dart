import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/model/service/contact_service.dart';
import 'package:contact_list/src/presentation/screens/contact.dart';
import 'package:contact_list/src/presentation/widgets/header.dart';
import 'package:contact_list/src/presentation/widgets/home/contacts.dart';
import 'package:contact_list/src/presentation/widgets/home/modal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions { asc, desc }

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

  void _handleDeleteContact(ContactDTO contact) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm!'),
        content: Text('Delte?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () async {
              Navigator.pop(context);
              Navigator.pop(context);

              await _service.delete(contact.id);

              _findContacts();
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      )
    );
  }

  void _handleCallContact(ContactDTO contact) {
    launch("tel:${contact.phone}");

    Navigator.pop(context);
  }

  void _sortList(OrderOptions option) {
    switch (option) {
      case OrderOptions.asc:
        _contacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case OrderOptions.desc:
        _contacts.sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
    }

    setState(() { });
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) =>
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ModalButton(() => _handleCallContact(_contacts[index]), 'Call'),
                ModalButton(() => _handleChangeContactPage(contact: _contacts[index]), 'Edit'),
                ModalButton(() => _handleDeleteContact(_contacts[index]), 'Delete'),
              ],
            ),
          ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        Text('Contacts'),
        [
          PopupMenuButton<OrderOptions>(
            itemBuilder: (context) => <PopupMenuEntry<OrderOptions>>[
              const PopupMenuItem<OrderOptions>(
                child: Text('ASC'),
                value: OrderOptions.asc,
              ),
              const PopupMenuItem(
                child: Text('DESC'),
                value: OrderOptions.desc,
              )
            ],
            onSelected: _sortList,
          )
        ]
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _handleChangeContactPage,
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: Contacts(
        _contacts,
        _showOptions
      ),
    );
  }
}
