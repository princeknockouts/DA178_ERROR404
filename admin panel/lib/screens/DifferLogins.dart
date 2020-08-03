import 'package:admin_panel/screens/LoginPage.dart';
import 'package:admin_panel/screens/elevatorscreen/invigilatorlogin.dart';
import 'package:flutter/material.dart';

class DifferLogin extends StatefulWidget {
  @override
  _DifferLoginState createState() => _DifferLoginState();
}

class _DifferLoginState extends State<DifferLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("ERROR 404"),
      ),
      body: Container(
        child: Center(
          child:Row(
            children: [
            Expanded(
              child: InkWell(
                onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return LoginPage();
                    }));
                },
                        child: Container(
                          margin: EdgeInsets.all(20.0),
                          padding: EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                          ),
                          child: Image.network("https://memegenerator.net/img/instances/400x/72405711.jpg"))
              ),
            ),


              Expanded(
                      child: InkWell(
                           onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                      return InviLoginPage();
                  }));
              },
                          child: Container(
                           margin: EdgeInsets.all(20.0),
                          padding: EdgeInsets.all(20.0),
                           width: MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.0),
                          ),
                          child: Image(image: AssetImage('assests/logoerror.png')))
                      ),
                    ),

            ],
          ) ,
          ),
      ),
    );
  }

}