import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'homepage.dart';
void main() {
  runApp(MaterialApp( home: login(),
    )
  );
}

class login extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<login> {
  bool _valName=false;
  bool _valPass=false;
  final name = new TextEditingController(text: "@gmail");
  final pass = new TextEditingController(text: "");



  Future _saveDetails(String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b=prefs.getString("ip").toString();
    var data = await http.post(Uri.parse("http://"+b+":3000/flutter_login"),
        body: {"name":name,"email":email});
    print(data);
    var jsondata = json.decode(data.body);
//    if(jsonData["res"])

    if(jsondata["res"]=="false"){
      setState(() {
        print("kkkkkkkkkkkkk");
      });
    }
    else{
      if(jsondata["res"]=="true"){
        setState(() {
          print("lllllllllllllll");
        });
        //save the data returned from server
        //and navigate to home page
        String uid = jsondata["lid"].toString();
        String name = jsondata["name"].toString();
        String email = jsondata["email"].toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("lid",uid);
        prefs.setString("name",name);
        prefs.setString("email",email);
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new MyStatefulWidget(uid:name,ue:email))
        );

        //user shared preference to save data
      }
      else{
        print("lllllllllllllllllllllllllllll");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PROSGEN - THE PROMISING GENERATION'),

        ),
        body:

        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[
                 Image(
                  image: AssetImage('images/login.jpg'),
                   height:175,
                   width: 175,
               ),

                Text('Hello Again!',
               style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24,
               )
                ),
                Text(''
                    'Welcome back, you\'ve been missed!',
                style: TextStyle(
                  fontSize: 20,
                ),
                ),
                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                      hintText: 'Enter Your Name',
                      errorText: _valName?'Required':null,
                    ),
                    controller: name,
                  ),
                ),

              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder() ,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: _valPass?'Required':null,
                  ),
                  controller: pass,
                ),
              ),

                Padding(
                  padding: EdgeInsets.all(25),
                  child: MaterialButton(
                    child: Text('Login', style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                    color: Colors.blue[400],
                    textColor: Colors.white70,
                    onPressed: () {
                      name.text.isEmpty?_valName=true:_valName=false;
                      pass.text.isEmpty?_valPass=true:_valPass=false;
                      if( _valName){
                        Fluttertoast.showToast(
                          msg: "Username required",
                        );
                      } else if(_valPass ){
                        Fluttertoast.showToast(
                          msg: "password required",
                        );
                      }
                      else {
                        _saveDetails(name.text, pass.text);
                      }
                    },
                  ),
                ), Padding(
                  padding: EdgeInsets.all(25),
                  child: MaterialButton(
                    child: Text('REGISTER', style: TextStyle(fontSize: 20.0,),),
                    color: Colors.blue[400],
                    textColor: Colors.white70,
                    onPressed: ()  async {
                     Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => new register())
                      );
                      },


                  ),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text('Not a member?'),
                Text(
                  'Register now',
                  style:TextStyle(
                    color:Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

              ],
            )
        )

    );
  }
}