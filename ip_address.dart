import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'dart:convert';
void main() {
  runApp(MaterialApp( home: MyApp(),
    routes: <String,WidgetBuilder>
    {
      '/login':(BuildContext context)=>new login()
    },
  )
  );
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {



  final ip = new TextEditingController(text: "192.168.0.156");
  bool _valName=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Flutter TextField Example'),
            automaticallyImplyLeading: false
    ),
    body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(200),

    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Padding(
    padding: EdgeInsets.all(15),
    child: TextField(
    decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'IP ADDRESS',
    hintText: 'ENTER IP ADDRESS',
    errorText: _valName?'Required':null,
    ),
      controller: ip,
    ),
    ),
      Padding(
        padding: EdgeInsets.all(25),
        child: MaterialButton(
          child: Text('SAVE', style: TextStyle(fontSize: 20.0),),
          color: Colors.blue[900],
          textColor: Colors.white70,
          onPressed: () async {
            ip.text.isEmpty?_valName=true:_valName=false;
            if( _valName == false) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("ip", ip.text);
              Navigator.pushNamed(context, '/login');
            }
          },
        ),
      ),
    ],
    )
    )
    );
  }
}