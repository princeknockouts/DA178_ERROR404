import 'package:admin_panel/auth/authService.dart';
import 'package:admin_panel/screens/DifferLogins.dart';
import 'package:admin_panel/screens/HomePage.dart';
import 'package:admin_panel/screens/elevatorscreen/invigilatorlogin.dart';
import 'package:admin_panel/screens/elevatorscreen/iviHomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
     
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:DifferLogin(),
    );
  }
}
