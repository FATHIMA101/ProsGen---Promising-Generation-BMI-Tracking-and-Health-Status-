import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(MaterialApp( home: rate_doctor(),
  ));
}

class rate_doctor extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<rate_doctor> {
  final rating = new TextEditingController();

  Future _savereg() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var b = prefs.getString("ip").toString();
    var data = await http.post(Uri.parse("http://" + b + ":3000/flutter_rate"),
        body: {"rating": prefs.getString("rate").toString(),
          "lid":prefs.getString("lid").toString(),
          "did":prefs.getString("did").toString()
    });
    var jsondata = json.decode(data.body);
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          title: Text('RATE DOCTOR'),
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
                    child: RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString("rate",rating.toString());
                      },
                    )
                ),

                Padding(
                  padding: EdgeInsets.all(20),
                  child: MaterialButton(
                    child: Text('RATE', style: TextStyle(fontSize: 20.0),),
                    color: Colors.blue[900],
                    textColor: Colors.white70,
                    onPressed: () async {

                      _savereg();

                    },
                  ),
                ),
              ],
            )
        )

    );
    throw UnimplementedError();
  }
}