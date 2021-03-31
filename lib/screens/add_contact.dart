import 'package:contact_app/models/contact_modal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  void _addContact() {
    var name = nameController.text;
    var phone = phoneController.text;
    var email = emailController.text;

    if (!_formkey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Name and contact no can not be empty"),
          duration: Duration(seconds: 1),
        ),
      );
      return;
    }
    var contact = Contact(name: name, phone_no: phone, email: email ?? "");
    setState(() {
      Hive.box('contacts').add(contact);
    });

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.greenAccent,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Contact Added !!"),
          ],
        )));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            top: size.height * 0.05,
            left: size.width * 0.1,
            //right: size.width * 0.1,
          ),
          width: size.width * 0.8,
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    //hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    }
                    return "Please enter the name";
                  },
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    //hintText: 'Enter a phone number',
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value.isEmpty || value.length != 10) {
                      return "Please enter valid phone number";
                    }
                    return null;
                  },
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.email),
                    //hintText: 'Enter your name',
                    labelText: 'Email Id',
                  ),
                  controller: emailController,
                  textInputAction: TextInputAction.done,
                ),
                Container(
                  padding: EdgeInsets.only(top: 40.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: _addContact,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Colors.blue,
                    //color: Colors.blue,
                    //textColor: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
