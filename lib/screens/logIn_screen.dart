import 'package:contact_app/screens/contact_screen.dart';
import 'package:flutter/material.dart';
import 'add_contact.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  void _submitdata(context) {
    if (_formkey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 10,
              ),
              Text("LoggedIn!"),
            ],
          )));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return Contacts();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts LogIn"),
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
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    }
                    return "Please enter the username!";
                  },
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.security),
                    //hintText: 'Enter a phone number',
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter valid password!";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                ),
                Container(
                  padding: EdgeInsets.only(top: 40.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 2,
                    onPressed: () => _submitdata(context),
                    child: Text(
                      "LogIn",
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
