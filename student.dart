import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prosgen/bmi_data.dart';
import 'package:prosgen/booking.dart';
import 'package:prosgen/single_student.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    student(),
  );
}

List<Joke> jokes = [];

class student extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<student> {


  Future<List<Joke>> _getJokes() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
//     var b2 = prefs.getString("ip").toString();
//     await http.get(Uri.parse("http://" + b2 + ":3000/flutter_student"));
//     var jsonData = json.decode(data.body);
// //    print(jsonData);


    var b1 = prefs.getString("ip").toString();
    final response = await http.post(
      Uri.parse("http://" + b1 + ":3000/flutter_student"),
      body: {'lid': prefs.getString("lid").toString()},
    );
    var jsonData = json.decode(response.body);
    jokes=[];
    for (var joke in jsonData["data"]) {
      Joke newJoke = Joke(joke["student_id"].toString(), joke["name"], joke["class"].toString(), joke["division"].toString(),joke["gender"].toString(),joke["DOB"].toString(),joke["blood_type"].toString(),joke["contact"].toString());
      jokes.add(newJoke);
    }
    print(jokes);
    return jokes;
  }

  save_id(int i) async{
    String stud_id= jokes[i].student_id;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("stud_id", stud_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STUDENT DETAILS"),
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
                    onLongPress: (){
                      print("long press"+ index.toString());
                    },
                    onTap: () async{
                      // Navigator.push(context, MaterialPageRoute(
                      //     builder: (context)=>Updateuser(
                      //       id:snapshot.data[index].id.toString(),
                      //       name:snapshot.data[index].name.toString(),
                      //       email:snapshot.data[index].email.toString(),
                      //       g:snapshot.data[index].g.toString(),
                      //       l:snapshot.data[index].l.toString(),
                      //       c:snapshot.data[index].c.toString(),
                      //     )));

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("idx",index.toString());

                      print("On tap"+ index.toString());
                      showAlertDialog(context);
                    },


                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(snapshot.data[index].name),
                    ),
                    subtitle:Text(snapshot.data[index].clas),
                    leading: CircleAvatar( child:
                    Text(snapshot.data[index].name.toString().substring(0,1).toUpperCase()),),

                  );
                },
              );
            }
          },
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget moreButton = TextButton(
      child: Text("View More"),
      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var b=prefs.getString("idx").toString();
        print("Index "+b);
        save_id(int.parse(b));
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new single_stud())
        );
      },
    );

    Widget bookingButton = TextButton(
      child: Text("Bookings"),
      onPressed:  () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var b=prefs.getString("idx").toString();
        print("Index "+b);
        save_id(int.parse(b));
        Navigator.push(context, new MaterialPageRoute(
            builder: (context) => new booking())
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Options"),
      actions: [
        moreButton,
        bookingButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}


class Joke {
final String student_id;
final String name;
final String clas;
final String division;
final String gender;
final String DOB;
final String blood_type;
final String contact;

Joke(this.student_id, this.name, this.clas, this.division,this.gender,this.DOB,this.blood_type,this.contact);


//  print("hiiiii");
}