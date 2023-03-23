import 'package:flutter/material.dart';
import 'package:loginpage/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget {

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  SharedPreferences? prefs;
  String id="0";
  String name="",hobby="",gender="",city="",password="";

  storedata() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      id=prefs!.getString('id')!;
      name=prefs!.getString("name")!;
      gender=prefs!.getString("gender")!;
      city=prefs!.getString("city")!;
      password=prefs!.getString("password")!;
      hobby=prefs!.getString("hobby")!;
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storedata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () async {
            await prefs!.clear();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return loginscreen();
            },));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: Column(
        children: [
          Text(id),
          Text(name),
          Text(gender),
          Text(hobby),
          Text(city),
          Text(password),
        ],
      ),
    );
  }
}
