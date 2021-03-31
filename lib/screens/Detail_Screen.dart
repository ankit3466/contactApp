import 'package:flutter/material.dart';
import 'package:contact_app/models/contact_modal.dart';

class Details extends StatelessWidget {
  final Contact contact;

  Details(this.contact);

  Widget containerField(String fieldName, String val) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        '$fieldName:  $val',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: isLandScape
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                containerField("Name", contact.name),
                containerField("Phone", contact.phone_no),
                containerField("Email", contact.email),
              ],
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.37,
                    child: Image.asset(
                      'assets/person.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  containerField("Name", contact.name),
                  containerField("Phone", contact.phone_no),
                  if (contact.email.isNotEmpty)
                    containerField("Email", contact.email),
                ],
              ),
            ),
    );
  }
}
