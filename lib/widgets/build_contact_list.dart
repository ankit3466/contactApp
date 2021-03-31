import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:contact_app/models/contact_modal.dart';
import 'package:contact_app/screens/Detail_Screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BuildContactList extends StatefulWidget {
  @override
  _BuildContactListState createState() => _BuildContactListState();
}

class _BuildContactListState extends State<BuildContactList> {
  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('contacts'),
      builder: (context, contactBox) {
        return ListView.builder(
            itemCount: contactBox.length,
            itemBuilder: (context, index) {
              final contact = contactBox.getAt(index) as Contact;
              return Card(
                elevation: 1.5,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      contact.name[0].toUpperCase(),
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    backgroundColor: Colors.blue,
                    radius: 25,
                  ),
                  title: Text(
                    contact.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(
                    contact.phone_no,
                    style: TextStyle(),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Do you want to Delete ?"),
                              content: Text(
                                  "This contact will be deleted from your phone permanantly."),
                              actions: [
                                FlatButton(
                                    onPressed: () {
                                      setState(() {
                                        Hive.box('contacts').deleteAt(index);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Ok",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.red))),
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancle",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                )
                              ],
                            );
                          });
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Details(contact)),
                    );
                  },
                ),
              );
            });
      },
    );
  }
}
