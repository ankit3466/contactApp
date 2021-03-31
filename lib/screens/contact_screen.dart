import 'package:contact_app/screens/add_contact.dart';
import 'package:contact_app/screens/logIn_screen.dart';
import 'package:contact_app/widgets/build_contact_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  void dispose() {
    Hive.box('contacts').compact();
    Hive.box('contacts').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox('contacts'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text("Contacts"),
                actions: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          }),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return AddContact();
                          }));
                        },
                        //color: Colors.lightBlue,
                      ),
                    ],
                  )
                ],
              ),
              body: BuildContactList(),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return AddContact();
                  }));
                },
              ),
            );
          }
        } else {
          return Scaffold();
        }
      },
    );
  }
}
