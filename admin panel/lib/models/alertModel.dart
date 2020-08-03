import 'package:flutter/material.dart';

class AlertModel{
  String img;
  String name;
  String timestamp;
  String classId;
  String className;
  String verify;
  String alertId;

  AlertModel({
    this.img,
    this.name,
    this.timestamp,
    this.classId,
    this.className,
    this.verify,
    this.alertId
  });

  AlertModel.fromMap(Map<String, dynamic> mapData) {
    this.name = mapData['name'].toString();
    this.img = mapData['img'].toString();
    this.timestamp = mapData['timestamp'].toString();
    this.classId = mapData['classId'].toString();
    this.className = mapData['className'].toString();
    this.verify = mapData['verify'].toString();
    this.alertId = mapData['alertId'].toString();
  }
      Map toMap(AlertModel alert) {
    var data = Map<String, dynamic>();
    data['name'] = alert.name;
    data['img'] = alert.img;
    data['timestamp'] = alert.timestamp;
    data['classId'] = alert.classId;
    data["className"] = alert.className;
    data["verify"] = alert.verify;
    data["alertId"] = alert.alertId;
    return data;
  }
}