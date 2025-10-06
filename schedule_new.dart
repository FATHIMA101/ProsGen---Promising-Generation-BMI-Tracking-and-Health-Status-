import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prosgen/student.dart';
import 'package:prosgen/single_student.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bmi_data.dart';

void main()
{
  runApp(
    schedule_new(),
  );
  }

class schedule_new extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<schedule_new> {



  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b1 = prefs.getString("ip").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_schedule"),
      body:{'doc_id': prefs.getString("did").toString()},
    );
    var jsonData = json.decode(response.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke( joke["schedule_id"].toString(),
          joke["date"],
          joke["time_from"].toString(),
          joke["to_time"].toString());
      jokes.add(newJoke);
    }
    return jokes;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SCHEDULE "),
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

                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("DATE :"+snapshot.data[index].date),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("FROM TIME : " + snapshot.data[index].time_from)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("TO TIME : " + snapshot.data[index].to_time)
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
  final String schedule_id;
  final String date;
  final String time_from;
  final String to_time;


  Joke( this.schedule_id,this.date, this.time_from, this.to_time);


}