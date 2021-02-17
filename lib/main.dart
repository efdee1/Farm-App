import 'package:body1/pages/root_page.dart';
import 'package:body1/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:body1/services/authentication.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user1 = Provider.of<User>(context);
    return StreamProvider.value(
      value: Auth().user,
      child: new MaterialApp(
          title: 'Mercy Records',
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new RootPage(auth: new Auth())),
    );
  }
}