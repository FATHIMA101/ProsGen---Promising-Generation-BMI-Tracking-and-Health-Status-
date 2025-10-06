import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prosgen/rate_doctor.dart';
import 'package:prosgen/suggestion.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    booking(),
  );
}

class booking extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<booking> {



  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b1 = prefs.getString("ip").toString();
    String b=prefs.getString("stud_id").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_booking"),
      body:{'stud_id': b},
    );
    var jsonData = json.decode(response.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(joke["booking_id"].toString(),
          joke["name"],
          joke["date"].toString(),
          joke["time_from"].toString(),
          joke["to_time"].toString(),
          joke["token"].toString(),
          joke["doctor_id"].toString()

      );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BOOKINGS "),
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
                      child: Text("TOKEN :"+snapshot.data[index].token),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Doctor Name : " + snapshot.data[index].name)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("Date : " + snapshot.data[index].date)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("FROM TIME : " + snapshot.data[index].time_from)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("TO TIME : " + snapshot.data[index].to_time)
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: MaterialButton(
                                child: Text('SUGGESTION', style: TextStyle(fontSize: 20.0),),
                                color: Colors.blue[900],
                                textColor: Colors.white70,

                                onPressed:() async{
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString("bid", snapshot.data[index].bid);
                                  //
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => new suggestion())
                                  );
                                }


                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: MaterialButton(
                                child: Text('RATE DOCTOR', style: TextStyle(fontSize: 20.0),),
                                color: Colors.blue[900],
                                textColor: Colors.white70,

                                onPressed:() async{

                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString("bid", snapshot.data[index].bid);
                                  prefs.setString("did", snapshot.data[index].doctor_id);
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => new rate_doctor())
                                  );
                                }


                            ),
                          ),

                        ]),



                    leading: CircleAvatar(child:
                    Text(snapshot.data[index].token.toString()
                        .substring(0, 1)
                        .toUpperCase()),),

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
  final String bid;
  final String name;
  final String date;
  final String time_from;
  final String to_time;
  final String token;
  final String doctor_id;

  Joke(this.bid,this.name, this.date, this.time_from, this.to_time,this.token,this.doctor_id);

//  print("hiiiii");
}