import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prosgen/doctor.dart';
import 'package:prosgen/doctor_new.dart';
import 'package:prosgen/student.dart';
import 'package:prosgen/tip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prosgen/ip_address.dart';
import 'profile.dart';


class MyStatefulWidget extends StatefulWidget {
  String uid,ue;
  MyStatefulWidget({Key? key, required this.uid,required this.ue}) : super(key: key);
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text('PROSGEN- THE PROMISING GENERATION'),
      ),

      body: Center(
        child:
        Image(
          image: AssetImage('images/bubble.png'),
          height:175,
          width: 175,
        ),

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.uid),
              accountEmail: Text(widget.ue),
              currentAccountPicture: CircleAvatar(
//                backgroundColor: Colors.yellow,
//                 backgroundImage: AssetImage("favicon.png"),
               child: Text(widget.uid.toString().substring(0,1).toUpperCase()),
              ),
            ),
            ListTile(
              title: new Text("View profile"),
              leading: new Icon(Icons.accessibility_new),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new Userprofile())
                );

              },
            ),
            Divider( height: 0.1,),
            ListTile(
              title: new Text("Student"),
              leading: new Icon(Icons.emoji_people_rounded),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new student())
                );

              },
            ),
            ListTile(
              title: new Text("Doctor"),
              leading: new Icon(Icons.people_alt_outlined),
              onTap: (){

                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new doctor_new())

                );
              },
            ),
            ListTile(
              title: new Text("Tips"),
              leading: new Icon(Icons.local_offer),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new tips())
                );
              },
            ),

            ListTile(
              title: new Text("Logout"),
              leading: new Icon(Icons.logout),

              onTap: (){
                exit(0);

              },
            )
          ],
        ),
      ),
    );
  }
}