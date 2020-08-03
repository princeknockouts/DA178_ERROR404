import 'dart:typed_data';

import 'package:admin_panel/models/alertModel.dart';
import 'package:admin_panel/screens/AlertDetail.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io' as Io;

class AlertWidget extends StatefulWidget {
   final AlertModel alertModel;
  AlertWidget(this.alertModel);
  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  String date;
  Uint8List  decodedBytes;
  var decoded;
  @override
  void initState(){
    super.initState();
    decoded = base64.decode(widget.alertModel.img);
  }
  @override
  Widget build(BuildContext context) {
    AlertModel alertModel=widget.alertModel;      
    gotoDetails() {
      Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    pageBuilder: (context, _, __) =>AlertDetails(widget.alertModel)));
    }
    return GestureDetector(
          onTap:()=>gotoDetails(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.3,
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              gradient: LinearGradient(
                colors: [Colors.blue,Colors.blue[600],Colors.white],
              )
          ),
              padding: EdgeInsets.fromLTRB(10.0, 10.0,10.0, 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                   Container(
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.height*0.4,
                 child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.memory(decoded),
                  ),
               ),
               SizedBox(width: 20.0,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(widget.alertModel.name,style: TextStyle(fontSize:25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                    getTimeStamp(widget)
                  ]
                ),
              ) 
              ]
              ),
            ),
          );

        }
      }
                  
getTimeStamp(AlertWidget widget) {
String date = new DateTime.fromMillisecondsSinceEpoch(int.parse("1522129071") * 1000).toString();
return Text(date,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.white),);
}
