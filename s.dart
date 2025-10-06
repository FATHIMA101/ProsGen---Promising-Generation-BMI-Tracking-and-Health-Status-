import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ip_address.dart';
import 'profile.dart';

String em="";
class UserAuth {

  static int seconds = 10000000;
  static String username="";
  static String password="qqqqqqqqqqqqq";
  static String key = "abc123";

  static Future<String> generateAuthCode(seconds, username, password, key) async{
    var result = "something";
    print("Seconds: seconds, Username: username, Password: password, Key: key");

    return result;
  }

}


void main() {
  print(UserAuth.key+"mmmmmmmmmmmmmmmmmmmmmmmmmmm");
  runApp(MaterialApp( home: MyStatefulWidget())
  );
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);


  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _count = 0;
  String id="";
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Flutter Scaffold Example'),
      ),

      body: Center(
        child: Text('We have pressed the button $_count times.'),

      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  async {
          _count++;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final String em=prefs.getString("lid").toString();
        },
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        elevation: 20.0,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text("risskannur@gmail.com"),
              currentAccountPicture: CircleAvatar(
//                backgroundColor: Colors.yellow,
//                 backgroundImage: AssetImage("favicon.png"),
//                child: Image.asset("favicon.png"),
              ),
            ),
            ListTile(
              title: new Text("View profile"),
              leading: new Icon(Icons.accessibility_new),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(
                    builder: (context) => new MyApp())
                );

              },
            ),
            Divider( height: 0.1,),
            ListTile(
              title: new Text("Student"),
              leading: new Icon(Icons.inbox),
              onTap: (){
              },
            ),
            ListTile(
              title: new Text("Doctor"),
              leading: new Icon(Icons.people),
              onTap: (){
              },
            ),
            ListTile(
              title: new Text("Tips"),
              leading: new Icon(Icons.local_offer),
              onTap: (){
              },
            ),
            ListTile(
              title: new Text("Bookings"),
              leading: new Icon(Icons.pending_actions),
              onTap: (){
              },
            ),
            ListTile(
              title: new Text("Logout"),
              leading: new Icon(Icons.people),
              onTap: (){
              },
            )
          ],
        ),
      ),
    );
  }
}