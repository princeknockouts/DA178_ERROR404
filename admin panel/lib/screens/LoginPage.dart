import 'package:admin_panel/auth/authService.dart';
import 'package:admin_panel/screens/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;

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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  ),
                  height: MediaQuery.of(context).size.height*0.6,
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Card(
                    elevation: 10.0,
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
                                      child: Image(image: AssetImage('assests/logoerror.png')),
                                    )),
                                   Padding(
                                    padding: EdgeInsets.only(
                                        left: 25.0,
                                        right: 25.0,
                                        top: 20.0,
                                        bottom: 5.0),
                                    child: Container(
                                      height: 50.0,
                                      child: Text("Admin Login",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.blue),),
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
                                       FirebaseUser user= await AuthService().signInInvi(email, password)
                                       .then((FirebaseUser user) async{
                                        gotoAdminPage();
                                      }).catchError((e) => print(e));
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(20.0),
                                        padding: EdgeInsets.all(20.0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                          color: Colors.blue.withOpacity(0.7),
                                        ),
                                        child: Center(child: Text('Sign in',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),))))
                              ],
                            ))
                      ],
                    ),
                  )),
            ));
  }
  gotoAdminPage(){
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return HomePage();
    }));
  }
}