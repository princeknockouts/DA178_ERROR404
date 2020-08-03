import 'package:admin_panel/auth/authService.dart';
import 'package:admin_panel/auth/dataService.dart';
import 'package:admin_panel/models/alertModel.dart';
import 'package:admin_panel/models/invigilator.dart';
import 'package:admin_panel/screens/elevatorscreen/iviProfile.dart';
import 'package:admin_panel/widget/AlertWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'invigilatorRegister.dart';

class InViHomePage extends StatefulWidget {
  @override
  _InViHomePageState createState() => _InViHomePageState();
}

class _InViHomePageState extends State<InViHomePage> {
   //for database
  DataBase _dataMethods=DataBase();
  Invigilator inviModel;
  String classid="200";
  AuthService _authMethods = AuthService();
  List<AlertModel> alertList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authMethods.getUserDetails().then((Invigilator invigilator) {
        setState(() {
          print("details "+invigilator.email);
          print("calss id "+invigilator.classId.toString());
          classid=invigilator.classId.toString();
          inviModel=invigilator;
        });
    });
  }
   createDrawer(){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.white,),
              accountName:Text("") ,
              accountEmail: Text("firebaseUser==null?"":firebaseUser.email"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://boostlikes-bc85.kxcdn.com/blog/wp-content/uploads/2019/08/Facebook-Page-Admin.jpg"
                  ,),),),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.transparent,
            ),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,),
            leading: Icon(Icons.add,color:  Colors.blue,),
            title: Text('Profile',),
            onTap: () {
               Navigator.push(context,MaterialPageRoute(builder: (context){
              return InviProfile(inviModel);
            }));
            },
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,),
            leading: Icon(Icons.clear,color:   Colors.blue,),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: createDrawer(),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Card(
          child: SingleChildScrollView(
              child: Column(
              children: [
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 5.0),
                  child: Text("Detection Found",style: TextStyle(color:Colors.blueAccent,fontSize: 30.0,fontWeight: FontWeight.bold,),),
                  ),
                
                  createListRecntlyAdd(),
                  SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
  getInviData()   {
 
  }
  createListRecntlyAdd()  {
   return Container(
     height: MediaQuery.of(context).size.height*0.8,
     width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      child: Card(
          elevation: 10.0,
          child:   StreamBuilder<List<AlertModel>>(
            stream: _dataMethods.fetchparticularListAlerts(classid).asStream(),
            builder: (context,AsyncSnapshot<List<AlertModel>> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (_,index){
                     return AlertWidget(
                  snapshot.data[index]
                  );
                }
                );
              }
              return Center(child: CircularProgressIndicator());
            }
          ),
      ),
    );
}
}