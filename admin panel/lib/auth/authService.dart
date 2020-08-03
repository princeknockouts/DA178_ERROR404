import 'package:admin_panel/models/invigilator.dart';
import 'package:admin_panel/screens/HomePage.dart';
import 'package:admin_panel/screens/LoginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;

class AuthService{

  static final Firestore firestore = Firestore.instance;
  static final Firestore _firestore = Firestore.instance;
 static final CollectionReference _inviCollection =
      _firestore.collection("Invigilator");


    final FirebaseAuth _auth = FirebaseAuth.instance;
   //Handle Authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
  //Sign Out
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Sign in
  signIn(email, password) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      print('Signed in');
    }).catchError((e) {
      print(e);
    });
  }
    //Sign in
  Future<FirebaseUser> signInInvi(email, password) async{
     final AuthResult user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
     assert (user != null);
    assert (await user.user.getIdToken() != null);
    //enter data to firebase
    return user.user;
  }
  
  
  Future<FirebaseUser> handleSignUp(phone, email, password) async {
    final AuthResult user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
//    user = result.user;

    assert (user != null);
    assert (await user.user.getIdToken() != null);
    //enter data to firebase
    return user.user;
  }

    Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<Invigilator> getUserDetails() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    print("enter");
    print("uid "+currentUser.uid.toString());
    DocumentSnapshot documentSnapshot =
        await _inviCollection.document(currentUser.uid).get();

    return Invigilator.fromMap(documentSnapshot.data);
  }


    Future<Invigilator> getUserDetailsById(id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _inviCollection.document(id).get();
      return Invigilator.fromMap(documentSnapshot.data);
    } catch (e) {
      print(e);
      return null;
    }
  }
  
  //add user data to firebase
  Future<void> addDataToDb(FirebaseUser currentUser, String username,
      String Phone, String Password) async {
    Invigilator user = Invigilator(
        inviId: currentUser.uid,
        email: currentUser.email,
        phoneno: Phone,
        password: Password,
        classId: "Not Allocated"
    );
    firestore
        .collection("Invigilator")
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }
}