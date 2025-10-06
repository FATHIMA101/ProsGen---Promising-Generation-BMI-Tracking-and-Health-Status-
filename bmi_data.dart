import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'doctor.dart';

void main() {
  runApp(
    bmi_data(),
  );
}

List<Joke> jokes = [];
class bmi_data extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<bmi_data> {


  bool _isAcceptTermsAndConditions = false;

  Future<List<Joke>> _getJokes() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
//     var b2 = prefs.getString("ip").toString();
//     await http.get(Uri.parse("http://" + b2 + ":3000/flutter_student"));
//     var jsonData = json.decode(data.body);
// //    print(jsonData);


    var b1 = prefs.getString("ip").toString();
    var b2 = prefs.getString("stud_id").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_bmi"),
      body: {'stud_id': b2},
    );
    var jsonData = json.decode(response.body);

    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(joke["date"].toString(), joke["weight"], joke["height"].toString(), joke["BMI"].toString(),joke["bmi_status"].toString());
      jokes.add(newJoke);
    }
    print(jokes);
    return jokes;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI STATUS "),
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
                      child: Text(snapshot.data[index].bmi_data),
                    ),
                    subtitle:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("Date : " + snapshot.data[index].date)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("HEIGHT : " + snapshot.data[index].height)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("WEIGHT : " + snapshot.data[index].weight)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: Text("BMI  : " + snapshot.data[index].bmi)
                          ),
                          Padding(
                              padding: EdgeInsets.all(5),
                              child: MaterialButton(
                                child: Text('VIEW DOCTORS', style: TextStyle(fontSize: 20.0),),
                                color: Colors.blue[900],
                                textColor: Colors.white70,

                                onPressed:
                                snapshot.data[index].bmi_data !="NORMAL"
                                    ? () {
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => new doctor())
                                  );
                                }
                                    : null,

                              ),
                          ),

                        ]),

                    leading: CircleAvatar(child:
                    Text(snapshot.data[index].bmi_data.toString()
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
  final String date;
  final String weight;
  final String height;
  final String bmi;
  final String bmi_data;

  Joke(this.date, this.weight, this.height, this.bmi,this.bmi_data);
//  print("hiiiii");
}