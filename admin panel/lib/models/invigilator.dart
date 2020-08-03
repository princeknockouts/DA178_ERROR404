class Invigilator{
  String name;
  String email;
  String password;
  String phoneno;
  String inviId;
  String classId;

   Invigilator({
    this.name,
    this.email,
    this.password,
    this.phoneno,
    this.inviId,
    this.classId
  });

  Invigilator.fromMap(Map<String, dynamic> mapData) {
    this.name = mapData['name'].toString();
    this.email = mapData['email'].toString();
    this.inviId = mapData['inviId'].toString();
    this.phoneno = mapData['phoneno'].toString();
    this.password = mapData['password'].toString();
    this.classId = mapData['classId'].toString();
  }
    Map toMap(Invigilator user) {
    var data = Map<String, dynamic>();
    data['name'] = user.name;
    data['email'] = user.email;
    data['inviId'] = user.inviId;
    data['phoneno'] = user.phoneno;
    data["password"] = user.password;
    data["classId"] = user.classId;
    return data;
  }
}