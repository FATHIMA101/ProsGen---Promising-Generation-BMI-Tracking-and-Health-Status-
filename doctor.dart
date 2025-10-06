import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prosgen/schedule.dart';
import 'package:prosgen/schedule_new.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    doctor(),
  );
}

class doctor extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<doctor> {



  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b1 = prefs.getString("ip").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_doctor"),
      body:{},
    );
    var jsonData = json.decode(response.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke( joke["doctor_id"].toString(),joke["name"],
          joke["Qualification"].toString(),
          joke["hospital"].toString(),
          joke["contact"].toString());
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DOCTORS "),
      ),
      body:


      Container(

        child:
        FutureBuilder(
          future: _getJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
//              print("snapshot"+snapshot.toString());
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading..."),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onLongPress: () {
                      print("long press" + index.toString());
                    },
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context)=>Updateuser(
                      //       id:snapshot.data[index].id.toString(),
                      //       name:snapshot.data[index].name.toString(),
                      //       email:snapshot.data[index].email.toString(),
                      //       g:snapshot.data[index].g.toString(),
                      //       l:snapshot.data[index].l.toString(),
                      //       c:snapshot.data[index].c.toString(),
                      //     )));
                      print("On tap" + index.toString());
                    },

                  //   title: Padding(
                  //     padding: const EdgeInsets.only(bottom: 8.0),
                  //     child: Text(snapshot.data[index].name),
                  //   ),
                  //   subtitle: Text(snapshot.data[index].Qualification),
                  //   leading: CircleAvatar(child:
                  //   Text(snapshot.data[index].name.toString()
                  //       .substring(0, 1)
                  //       .toUpperCase()),),
                  //

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(snapshot.data[index].name),
                    ),
                    subtitle:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("NAME: " + snapshot.data[index].name)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("QUALIFICATION :" + snapshot.data[index].Qualification)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("HOSPITAL: " + snapshot.data[index].hospital)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("CONTACT:" + snapshot.data[index].contact)
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: MaterialButton(
                              child: Text('SCHEDULE', style: TextStyle(fontSize: 20.0),),
                              color: Colors.blue[900],
                              textColor: Colors.white70,

                              onPressed:() async{
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("did", snapshot.data[index].did);
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => new schedule())
                                );
                              }


                            ),
                          ),

                        ]),

                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


class Joke {

  final String did;
  final String name;
  final String Qualification;
  final String hospital;
  final String contact;

  Joke(this.did,this.name, this.Qualification, this.hospital,this.contact);

//  print("hiiiii");
}