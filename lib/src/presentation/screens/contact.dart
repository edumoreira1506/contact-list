import 'package:contact_list/src/model/dto/contact.dart';
import 'package:contact_list/src/presentation/widgets/circle_image.dart';
import 'package:contact_list/src/presentation/widgets/header.dart';
import 'package:contact_list/src/presentation/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class ContactPage extends StatefulWidget {
  final ContactDTO contact;
  final void Function(ContactDTO) onSave;

  ContactPage({ this.contact, this.onSave });

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

  void _onSave() {
    setState(() {
      _contact.phone = _phone.text;
      _contact.email = _email.text;
      _contact.name = _name.text;

      Navigator.pop(context);

      widget.onSave(_contact);
    });
  }

  Future<bool> _confirm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm!'),
        content: Text('Save alterations?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);

              _onSave();
            },
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      )
    );

    return Future.value(false);
  }

  void _handleChangeImage() {
    ImagePicker.pickImage(source: ImageSource.camera).then((file) {
      if (file == null) return;

      setState(() {
        _contact.img = file.path;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: Header(
            Text(_contact.name ?? 'New Contact'),
            []
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _onSave,
            child: Icon(Icons.save),
            backgroundColor: Colors.red,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: CircleImage.big(image: _contact.img),
                  onTap: _handleChangeImage,
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
        ),
      onWillPop: _confirm
    );
  }
}
