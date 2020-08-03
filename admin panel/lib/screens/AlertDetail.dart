import 'dart:convert';
import 'dart:typed_data';

import 'package:admin_panel/models/alertModel.dart';
import 'package:admin_panel/widget/AlertWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class AlertDetails extends StatefulWidget {
  final AlertModel alertModel;
  AlertDetails(this.alertModel);

  @override
  _AlertDetailsState createState() => _AlertDetailsState();
}

class _AlertDetailsState extends State<AlertDetails> {
  Uint8List  decodedBytes;
  var decoded;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    decoded = base64.decode(widget.alertModel.img);
     print("alert id"+widget.alertModel.alertId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text("Detail Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),),
//        bottom: createSearchBar(),
      ),
      body: SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
             margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          padding: EdgeInsets.fromLTRB(10.0, 10.0,10.0, 10.0),
          child:Card(
            elevation: 10.0,
            child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                children:[
                  Hero(tag: "flutterLogo", child:FlutterLogo(size: 100.0,)),
                  Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 5.0),
                child: Text("",style: TextStyle(color:Colors.blueAccent,fontSize: 30.0,fontWeight: FontWeight.bold,),),
              ),
                  Container(
                   width: MediaQuery.of(context).size.width*0.5,
                   height:  MediaQuery.of(context).size.width*0.3,
                   child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.memory(decoded),
                    ),
                  ),
                   SizedBox(height: 30.0,),
                    Padding(
                      padding: const EdgeInsets.only(left:10.0),
                      child: Text(widget.alertModel.name,style: TextStyle(fontSize: 35.0,fontWeight: FontWeight.bold,color: Colors.black),),
                    ),
                     SizedBox(height: 20.0,),
                    getTimeStamp(),
                    SizedBox(height: 20.0,),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.8,
                      child: FlatButton(
                        color: Colors.blueAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        onPressed: ()=>updateAlert(),
                        child: Text("Action",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
            ),
            SizedBox(height: 50.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 5.0),
                child: Text("",style: TextStyle(color:Colors.blueAccent,fontSize: 30.0,fontWeight: FontWeight.bold,),),
              ),
              ]
          ),
        ),
        ),
      ),
    )
    );
  }
  updateAlert(){
      AlertModel prevAlertModel=widget.alertModel;
       final Firestore firestore = Firestore.instance;
      
       AlertModel alertModel=AlertModel
       (
       classId: prevAlertModel.classId,
       alertId:prevAlertModel.alertId,
       name:prevAlertModel.name,
       img:prevAlertModel.img,
       timestamp:prevAlertModel.timestamp,
       verify:"1",
       className:prevAlertModel.className,
       );
      firestore
        .collection("Alert")
        .document(widget.alertModel.alertId)
        .setData(prevAlertModel.toMap(alertModel)).then((value){
          Navigator.pop(context);  
        });
     
  }
   getTimeStamp(){
    String date = new DateTime.fromMillisecondsSinceEpoch(int.parse("1522129071") * 1000).toString();
    return Text(date,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.black54),);
  }
}