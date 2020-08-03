import 'package:admin_panel/auth/authService.dart';
import 'package:admin_panel/models/invigilator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class InviProfile extends StatefulWidget {
  Invigilator invigilator;
  InviProfile(this.invigilator);
  @override
  _InviProfileState createState() => _InviProfileState();
}

class _InviProfileState extends State<InviProfile> {
  String email,name, classId,phoneno;
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
                height: MediaQuery.of(context).size.height*0.8,
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
                                      initialValue: widget.invigilator.email,
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
                                      initialValue: widget.invigilator.name,
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
                                       initialValue: widget.invigilator.phoneno,
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
                                        padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 5.0),
                                        child: Text("Change Class",style: TextStyle(color:Colors.blue,fontSize: 30.0,fontWeight: FontWeight.bold,),),
                                      ),
                                  Padding(
                                  padding: EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 20.0,
                                      bottom: 5.0),
                                  child: Container(
                                    height: 50.0,
                                    child: TextFormField(
                                       initialValue: widget.invigilator.classId,
                                      obscureText: true,
                                      decoration:
                                          InputDecoration(hintText: 'Class Id'),
                                      validator: (value) => value.isEmpty
                                          ? 'Class Id'
                                          : null,
                                      onChanged: (value) {
                                        this.classId = value;
                                      },
                                    ),
                                  )),
                              InkWell(
                                  onTap: () async {
                                    if(classId!=""){
                                      updateInvi();
                                    }
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(20.0),
                                      padding: EdgeInsets.all(20.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                        color: Colors.blue.withOpacity(0.7),
                                      ),
                                      child: Center(child: Text('Update',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),))))
                            ],
                          ))
                    ],
                  ),
                ))));
  }

   updateInvi(){
      Invigilator prevInviModel=widget.invigilator;
       final Firestore firestore = Firestore.instance;
      
       Invigilator inviModel=Invigilator
       (
          name:prevInviModel.name,
          email:prevInviModel.email,
          password:prevInviModel.password,
          phoneno:prevInviModel.phoneno,
          inviId:prevInviModel.inviId,
          classId:classId,
       );
      firestore
        .collection("Invigilator")
        .document(widget.invigilator.inviId)
        .setData(prevInviModel.toMap(inviModel)).then((value){
          Navigator.pop(context);  
        });
     
  }
}