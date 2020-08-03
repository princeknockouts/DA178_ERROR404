import 'package:admin_panel/auth/authService.dart';
import 'package:admin_panel/auth/dataService.dart';
import 'package:admin_panel/models/alertModel.dart';
import 'package:admin_panel/widget/AlertWidget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'elevatorscreen/invigilatorRegister.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   //for database
  DataBase _dataMethods=DataBase();

  List<AlertModel> alertList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _dataMethods.fetchAllAlerts().then((List<AlertModel> list) {
        setState(() {
          alertList = list;

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
            title: Text('Add Invigilator',),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios,),
            leading: Icon(Icons.clear_all,color: Colors.blue,),
            title: Text('All Invigilator'),
            onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context){
              return InviRegisterPage();
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
      drawer: createDrawer(),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: new IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text("Admin",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.0),),
      ),
       body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 5.0),
                child: Text("Recent Detection",style: TextStyle(color:Colors.blueAccent,fontSize: 30.0,fontWeight: FontWeight.bold,),),
                ),
                createListRecntlyAdd(),  
                SizedBox(height: 10.0),
                 Hero(tag: "flutterLogo", child:Image(image: AssetImage('assests/logoerror.png'))),
                // RaisedButton(
                //   onPressed: () {
                //     AuthService().signOut();
                //   },
                //   child: Center(
                //     child: Text('Sign out'),
                //   ),
                //   color: Colors.red,
                // )
              ],
            ),
          ),
        ),
      );
    }
  
   createFoodList(){
    return Container(
      height: MediaQuery.of(context).size.height,
      child: alertList.length==-1 ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: alertList.length,
          itemBuilder: (_,index){
            return AlertWidget(
              alertList[index],
            );
          }
      ),
    );
  }
createListRecntlyAdd() {
   return Container(
     height: MediaQuery.of(context).size.height*0.8,
     width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      child: Card(
          elevation: 10.0,
          child:   StreamBuilder<List<AlertModel>>(
            stream: _dataMethods.fetchAllAlerts().asStream(),
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