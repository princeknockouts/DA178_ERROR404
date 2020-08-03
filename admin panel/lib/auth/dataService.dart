import 'package:admin_panel/models/alertModel.dart';
import 'package:admin_panel/models/invigilator.dart';
import 'package:admin_panel/screens/HomePage.dart';
import 'package:admin_panel/screens/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class DataBase {
   DatabaseReference alertModelRef=FirebaseDatabase.instance.reference().child("Alerts");
   
    static final Firestore _firestore = Firestore.instance;

  final CollectionReference _messageCollection =
      _firestore.collection("Alert");

  



  Future<List<AlertModel>> fetchAllAlerts() async {
    List<AlertModel> alertList = List<AlertModel>();

    QuerySnapshot querySnapshot =await _firestore.collection("Alert").getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      AlertModel food= new AlertModel(
            name:  querySnapshot.documents[i].data['name'],
            img: querySnapshot.documents[i].data['img'],
            timestamp:querySnapshot.documents[i].data['timestamp'],
            classId:querySnapshot.documents[i].data['classId'],
            className:querySnapshot.documents[i].data['className'],
            verify:querySnapshot.documents[i].data['verify'],
            alertId:querySnapshot.documents[i].data['alertId'],

        );
        // alertList.add(AlertModel.fromMap(querySnapshot.documents[i].data));
        alertList.add(food);
    }
    return alertList;
  }


  Future<List<AlertModel>> fetchparticularListAlerts(classId) async {
    List<AlertModel> alertList = List<AlertModel>();

    QuerySnapshot querySnapshot =await _firestore.collection("Alert").getDocuments();
    for (var i = 0; i < querySnapshot.documents.length; i++) {
      AlertModel food= new AlertModel(
            name:  querySnapshot.documents[i].data['name'],
            img: querySnapshot.documents[i].data['img'],
            timestamp:querySnapshot.documents[i].data['timestamp'],
            classId:querySnapshot.documents[i].data['classId'],
            className:querySnapshot.documents[i].data['className'],
            verify:querySnapshot.documents[i].data['verify'],
            alertId:querySnapshot.documents[i].data['alertId'],
        );

        // alertList.add(AlertModel.fromMap(querySnapshot.documents[i].data));
        if(classId==food.classId&&food.verify=="1"){
        alertList.add(food);  
        }

    }
    return alertList;
  }

}