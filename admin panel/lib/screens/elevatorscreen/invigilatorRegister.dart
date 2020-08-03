import 'package:admin_panel/screens/elevatorscreen/iviHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_panel/auth/authService.dart';
import 'package:firebase/firebase.dart' as fb;

class InviRegisterPage extends StatefulWidget {
  @override
  _InviRegisterPageState createState() => _InviRegisterPageState();
}

class _InviRegisterPageState extends State<InviRegisterPage> {
  String email,name, password,phoneno;
  AuthService _authMethods =AuthService();
  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
              
                width: 300.0,
                child: Column(
                  children: <Widget>[
                    Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                               Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: Text("Invigilator Registration"),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Email'),
                                    validator: (value) => value.isEmpty
                                        ? 'Email is required'
                                        : validateEmail(value.trim()),
                                    onChanged: (value) {
                                      this.email = value;
                                    },
                                  ),
                                )),
                                 Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    decoration:
                                        InputDecoration(hintText: 'Name'),
                                    validator: (value) => value.isEmpty
                                        ? 'Name is required'
                                        : null,
                                    onChanged: (value) {
                                      this.name = value;
                                    },
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(hintText: 'Phone No'),
                                    validator: (value) => value.isEmpty
                                        ? 'Phone No is required'
                                        : null,
                                    onChanged: (value) {
                                      this.phoneno = value;
                                    },
                                  ),
                                )),
                                Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 20.0,
                                    bottom: 5.0),
                                child: Container(
                                  height: 50.0,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(hintText: 'Password'),
                                    validator: (value) => value.isEmpty
                                        ? 'Password is required'
                                        : null,
                                    onChanged: (value) {
                                      this.password = value;
                                    },
                                  ),
                                )),
                            InkWell(
                                onTap: () async {
                                  if (checkFields()) {
                                  FirebaseUser currentUser=await _authMethods.handleSignUp(phoneno, email, password)
                                  .then((FirebaseUser user) async{
                                    await _authMethods.addDataToDb(user,name,phoneno,password);
                                    gotoInviPage();
                                  }).catchError((e) => print(e));
                                  }
                                },
                                child: Container(
                                    height: 40.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                    ),
                                    child: Center(child: Text('Sign Up'))))
                          ],
                        ))
                  ],
                ))));
  }
  gotoInviPage(){
    Navigator.pop(context);
  }
}