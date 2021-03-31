import 'package:contact_app/screens/logIn_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/contact_modal.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contact App",
      home: LoginScreen(),
    );
  }
}
