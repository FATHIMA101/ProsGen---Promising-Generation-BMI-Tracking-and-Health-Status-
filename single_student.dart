import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'bmi_data.dart';

void main() {
  runApp(
    single_stud(),
  );
}

class single_stud extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<single_stud> {
  String localmage = '';
  String? b="";
  var textController_name = new TextEditingController();
  var textController_class = new TextEditingController();
  var textController_division = new TextEditingController();
  var textController_blood_type = new TextEditingController();
  var textController_DOB = new TextEditingController();
  var textController_contact = new TextEditingController();
  var textController_gender = new TextEditingController();

Future getUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String b=prefs.getString("stud_id").toString();
      print("Stud  "+ b);
      var b1 = prefs.getString("ip").toString();
      final response = await http.post(
        Uri.parse("http://" + b1 + ":3000/single_student"),
        body: {'stud_id': b},
      );
      if (response.statusCode == 200) {
        final profileData = json.decode(response.body);
        // onlineImage = profileData["m"]['image'].toString();
        name = profileData['name'].toString();
        clas = profileData['class'].toString();
        division = profileData['division'].toString();
        blood_type = profileData['blood_type'].toString();
        DOB = profileData['DOB'].toString();
        contact= profileData['contact'].toString();
        gender= profileData['gender'].toString();


        textController_name.text = name;
        textController_class.text = clas;
        textController_division.text = division;
        textController_blood_type.text = blood_type;
        textController_DOB.text = DOB;
        textController_contact.text = contact;
        textController_gender.text = gender;

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
            'STUDENT',
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
                              controller: textController_class,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.email),
                                labelText: 'class',
                                hintText: 'class',

                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_division,
                              decoration: InputDecoration(
                                icon: Icon(Icons.house),
                                border: OutlineInputBorder(),
                                labelText: 'division',
                                hintText: 'division',
                              ),
                            ),
                          ), Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_DOB,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.place),
                                labelText: 'DOB',
                                hintText: 'DOB',
                              ),
                            ),
                          ), Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_blood_type,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.post_add),
                                labelText: 'BLOOD TYPE',
                                hintText: 'blood type',
                              ),
                            ),
                          ),Padding(
                            padding: EdgeInsets.all(5),
                            child: TextField(
                              controller: textController_gender,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.post_add),
                                labelText: 'GENDER',
                                hintText: 'gender',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: MaterialButton(
                              child: Text('check bmi', style: TextStyle(fontSize: 20.0),),
                              color: Colors.blue[900],
                              textColor: Colors.white70,
                              onPressed: () {
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => new bmi_data())
                                );

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





  String name = '';
  String contact = '';
  String clas = '';
  String division = '';
  String blood_type = '';
  String DOB = '';
  String gender = '';

}
