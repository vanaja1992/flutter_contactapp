import 'package:contactapp/src/contacts/pages/mycontacts.dart';
import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Contact App",
      theme: ThemeData(
        primaryColor: Colors.blueAccent,

      ),
      home: const MyContacts(),
    );
  }
}
