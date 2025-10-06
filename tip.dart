import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    tips(),
  );
}

class tips extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<tips> {



  Future<List<Joke>> _getJokes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b1 = prefs.getString("ip").toString();
    final response = await http.post(
        Uri.parse("http://" + b1 + ":3000/flutter_tips"),
        body:{},
    );
    var jsonData = json.decode(response.body);
    List<Joke> jokes = [];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(joke["title"],
          joke["content"].toString(),
          joke["tips_date"].toString());
      jokes.add(newJoke);
    }
    return jokes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIP OF THE DAY "),
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
                      child: Text(snapshot.data[index].title),
                    ),
                    subtitle: Text(snapshot.data[index].content+"\n"+snapshot.data[index].tips_date),
                    leading: CircleAvatar(child:
                    Text(snapshot.data[index].title.toString()
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
  final String title;
  final String content;
  final String tips_date;

  Joke(this.title, this.content, this.tips_date);

//  print("hiiiii");
}