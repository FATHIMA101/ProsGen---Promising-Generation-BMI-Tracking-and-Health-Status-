import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    suggestion(),
  );
}

class suggestion extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<suggestion> {



  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b1 = prefs.getString("ip").toString();
    var b2 = prefs.getString("bid").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_suggestion"),
      body:{'b_id': b2},
    );
    var jsonData = json.decode(response.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(joke["suggestion"]
          );
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUGGESTION "),
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
                      child: Text("Suggestion " +(index+1).toString()+ " : "+snapshot.data[index].suggestions),
                    ),


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
  final String suggestions;


  Joke(this.suggestions);

}