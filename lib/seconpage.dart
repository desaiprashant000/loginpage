import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firstpage.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  SharedPreferences? prefs;

  mypref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              prefs!.setInt("login", 0);

              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return first();
                },
              ));
            },
            child: Text("LOGOUT")),
      ),
    );
  }
}
