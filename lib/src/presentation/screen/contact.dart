import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/presentation/widgets/circle_image.dart';
import 'package:contact_list/src/presentation/widgets/header.dart';
import 'package:contact_list/src/presentation/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactPage extends StatefulWidget {
  final ContactDTO contact;

  ContactPage({ this.contact });

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();

  ContactDTO _contact;

  @override
  void initState() {
    super.initState();

    if (widget.contact == null) {
      _contact = ContactDTO();
    } else {
      _contact = widget.contact;
      _phone.text = _contact.phone;
      _name.text = _contact.name;
      _email.text = _contact.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        Text(_contact.name ?? 'New Contact')
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: CircleImage.big(image: _contact.img)
            ),
            Input(
              controller: _name,
              label: 'Name',
              type: TextInputType.text,
            ),
            Input(
              controller: _phone,
              label: 'Phone',
              type: TextInputType.phone,
            ),
            Input(
              controller: _email,
              label: 'Email',
              type: TextInputType.emailAddress,
            )
          ],
        ),
      ),
    );
  }
}
