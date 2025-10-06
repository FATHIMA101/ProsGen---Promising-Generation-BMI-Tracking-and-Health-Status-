import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
void main() {
  runApp(MaterialApp( home: register(),));
}

class register extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<register> {
  bool _valName = false;
  bool _valContact = false;
  bool _valEmail = false;
  bool _valHouse = false;
  bool _valPlace = false;
  bool _valPost = false;
  bool _valPin = false;
  bool _valPass = false;
  final name = new TextEditingController();
  final contact = new TextEditingController();
  final email = new TextEditingController();
  final house = new TextEditingController();
  final place = new TextEditingController();
  final post = new TextEditingController();
  final pin = new TextEditingController();
  final password = new TextEditingController();

  Future _savereg(String name, String contact,String email,String house,String place,String post,String pin,String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b = prefs.getString("ip").toString();
    var data = await http.post(Uri.parse("http://" + b + ":3000/flutter_reg"),
        body: {"name": name,"contact":contact,"email":email,"house":house,"place":place,"post":post,"pin":pin,"password":password});
    var jsondata = json.decode(data.body);


    if (jsondata["res"] == "true") {
      setState(() {
        Navigator.pushNamed(context, '/login');
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROSGEN - THE PROMISING GENERATION'),
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(10),
        color: Colors.blueGrey[300],
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,

    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(5),
        child: TextField(
        decoration: InputDecoration(
        border: OutlineInputBorder() ,
        labelText: 'NAME',
        hintText: 'Enter your name',
          errorText: _valName?'Required':null,
      ),
          controller: name,
      ),
      ),
      Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'CONTACT',
      hintText: 'contact',
        errorText: _valContact?'Required':null,
      ),
        controller: contact,
      ),
      ), Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'EMAIL',
      hintText: 'Enter your email',
        errorText: _valEmail?'Required':null,
      ),
        controller: email,
      ),
      ), Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'HOUSE',
      hintText: 'House name',
        errorText: _valHouse?'Required':null,
      ),
        controller: house,
      ),
      ), Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'PLACE',
      hintText: 'PLACE',
        errorText: _valPlace?'Required':null,
      ),
        controller: place,
      ),
      ),
      Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'POST',
      hintText: 'POST',
        errorText: _valPost?'Required':null,
      ),
        controller: post,
      ),
      ),
      Padding(
      padding: EdgeInsets.all(5),
      child: TextField(
      decoration: InputDecoration(
      border: OutlineInputBorder() ,
      labelText: 'PIN',
      hintText: 'PIN',
        errorText: _valPin?'Required':null,
      ),
        controller: pin,
      ),
      ),
      Padding(
        padding: EdgeInsets.all(5),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder() ,
            labelText: 'PASSWORD',
            hintText: 'PASSWORD',
            errorText: _valPass?'Required':null,
          ),
          controller: password,
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: MaterialButton(
          child: Text('REGISTER', style: TextStyle(fontSize: 20.0),),
          color: Colors.blue[900],
          textColor: Colors.white70,
          onPressed: () {
            name.text.isEmpty?_valName=true:_valName=false;
            contact.text.isEmpty?_valContact=true:_valContact=false;
            email.text.isEmpty?_valEmail=true:_valEmail=false;
            house.text.isEmpty?_valHouse=true:_valHouse=false;
            place .text.isEmpty?_valPlace=true:_valPlace=false;
            post.text.isEmpty?_valPost=true:_valPost=false;
            pin.text.isEmpty?_valPin=true:_valPin=false;
            password.text.isEmpty?_valPass=true:_valPass=false;

            if( _valName){
              Fluttertoast.showToast(
                msg: "Name required",
              );
            } else if(_valContact ){
              Fluttertoast.showToast(
                msg: "contact required",
              );
            } else if(_valEmail ){
              Fluttertoast.showToast(
                msg: "Email required",
              );
            } else if(_valHouse ){
              Fluttertoast.showToast(
                msg: "House required",
              );
            }else if(_valPlace ){
              Fluttertoast.showToast(
                msg: "Place required",
              );
            }else if(_valPost ){
              Fluttertoast.showToast(
                msg: "Post required",
              );
            }else if(_valPin ){
              Fluttertoast.showToast(
                msg: "Pin required",
              );
            } else if(_valPass ){
              Fluttertoast.showToast(
                msg: "Password required",
              );
            }

            else{
              _savereg(
                  name.text,
                  contact.text,
                  email.text,
                  house.text,
                  place.text,
                  post.text,
                  pin.text,
                  password.text);
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