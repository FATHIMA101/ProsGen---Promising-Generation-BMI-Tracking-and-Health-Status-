import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    Userprofile(),
  );
}

class Userprofile extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Userprofile> {
  String localmage = '';
  String? b="";
  var textController_name = new TextEditingController();
  var textController_contact = new TextEditingController();
  var textController_email = new TextEditingController();
  var textController_house = new TextEditingController();
  var textController_place = new TextEditingController();
  var textController_post = new TextEditingController();
  var textController_pin = new TextEditingController();

  Future _savereg(String name, String contact,String email,String house,String place,String post,String pin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b = prefs.getString("ip").toString();
    var data = await http.post(Uri.parse("http://" + b + ":3000/flutter_update"),
        body: {
          "name": name,
          "contact": contact,
          "email": email,
          "house": house,
          "place": place,
          "post": post,
          "pin": pin,
          "lid":prefs.getString("lid").toString()
        });
    var jsondata = json.decode(data.body);


    if (jsondata["res"] == "true") {
      setState(() {
        Userprofile();
      });
    }
  }
  Future getUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      b=prefs.getString("lid").toString();
      var b1 = prefs.getString("ip").toString();
      final response = await http.post(
        Uri.parse("http://" + b1 + ":3000//viewprofile"),
        body: {'lid': b},
      );
      if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        // onlineImage = profileData["m"]['image'].toString();
        name = profileData['name'].toString();
        contact = profileData['contact'].toString();
        email = profileData['email'].toString();
        house = profileData['house'].toString();
        place = profileData['place'].toString();
        post = profileData['post'].toString();
        pin = profileData['pin'].toString();


        textController_name.text = name;
        textController_contact.text = contact;
        textController_email.text = email;
        textController_house.text = house;
        textController_place.text = place;
        textController_post.text = post;
        textController_pin.text = pin;
        return profileData;
      } else {
        print('Error 1');
        return 'Errorrrrrrrrrrr';
      }
    } catch (e) {
      return 'Errorrrr';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Profile',
          ),
        ),


        body:


        Container(

          child:
          FutureBuilder(
            future: getUserProfile(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
//              print("snapshot"+snapshot.toString());
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
              else {
                return Container(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // SizedBox(height: 20,),
                          // onlineImage.isNotEmpty ? CircleAvatar(radius: 20,backgroundImage: MemoryImage(base64Decode(onlineImage))) : Text("Noo image"),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_name,
                              decoration: InputDecoration(

                                border: OutlineInputBorder(),
                                icon: Icon(Icons.person),
                                labelText: 'NAME',
                                hintText:  'Enter your name',

                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_contact,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.phone),
                                labelText: 'CONTACT',
                                hintText: 'contact',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_email,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.email),
                                labelText: 'EMAIL',
                                hintText: 'email',

                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_house,
                              decoration: InputDecoration(
                                icon: Icon(Icons.house),
                                border: OutlineInputBorder(),
                                labelText: 'HOUSE',
                                hintText: 'HOUSE',
                              ),
                            ),
                          ), Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_place,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.place),
                                labelText: 'PLACE',
                                hintText: 'place',
                              ),
                            ),
                          ), Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_post,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.post_add),
                                labelText: 'POST',
                                hintText: 'POST',
                              ),
                            ),
                          ), Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_pin,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.pin),
                                labelText: 'PIN',
                                hintText: 'PIN',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: MaterialButton(
                              child: Text('UPDATE', style: TextStyle(fontSize: 20.0),),
                              color: Colors.blue[900],
                              textColor: Colors.white70,
                              onPressed: () {
                                _savereg(textController_name.text,textController_contact.text,textController_email.text,textController_house.text,textController_place.text,textController_post.text,textController_pin.text);

                              },
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }





  String onlineImage = '';
  String name = '';
  String contact = '';
  String pass = '';
  String email = '';
  String house = '';
  String place = '';
  String post = '';
  String pin = '';
}
