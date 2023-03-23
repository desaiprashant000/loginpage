import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginpage/seconpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class first extends StatefulWidget {
  const first({Key? key}) : super(key: key);

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();

  SharedPreferences? prefs;

  mypref() async {
    prefs = await SharedPreferences.getInstance();
  }

  String name = 'admin', password = 'admin';
  bool pass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: t,
              decoration: InputDecoration(
                labelText: 'name',
                hintText: 'enter your name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              controller: t1,
              obscureText: pass,
              decoration: InputDecoration(
                  labelText: 'password',
                  hintText: 'enter your password',
                  border: OutlineInputBorder(),
                  suffix: InkWell(
                    onTap: () {
                      pass = !pass;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.visibility_off_sharp,
                      color: Colors.black,
                    ),
                  )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (name == t.text && password == t1.text) {
                  prefs!.setInt("login", 1);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return second();
                    },
                  ));
                } else if (t.text == "" || t1.text == "") {
                  Fluttertoast.showToast(
                      msg: "enter name and password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Fluttertoast.showToast(
                      msg: "enter valid name or password",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: Text("LOGIN")),
        ],
      ),
    );
  }
}
