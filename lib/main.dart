import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: loginscreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class loginscreen extends StatefulWidget {
  const loginscreen({Key? key}) : super(key: key);

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  SharedPreferences? prefs;
  String? name;

  storedata() async {
    prefs = await SharedPreferences.getInstance();
    name = prefs!.getString("name");
    if (name != null) {
      print("not null==>$name");
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return dashboard();
        },
      ));
    }
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
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: t1,
          ),
          TextField(
            controller: t2,
          ),
          ElevatedButton(
              onPressed: () async {
                String user = t1.text;
                String pass = t2.text;
                var url = Uri.parse(
                    'http://venerating-radiator.000webhostapp.com/logincheck.php');
                var response = await http
                    .post(url, body: {'user': '$user', 'password': '$pass'});
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');

                List l = jsonDecode(response.body);
                print(l);

                if (l.length == 0) {
                  print("username or password does not exist");
                } else {
                  Map m = l[0];
                  await prefs!.setString('id', m['id']);
                  await prefs!.setString('name', m['name']);
                  await prefs!.setString('hobby', m['hobby']);
                  await prefs!.setString('gender', m['gender']);
                  await prefs!.setString('city', m['city']);
                  await prefs!.setString('password', m['password']);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return dashboard();
                    },
                  ));
                }
              },
              child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return myapp();
                  },
                ));
              },
              child: Text("Register Now"))
        ],
      ),
    );
  }
}

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  String gender = "Male";
  bool isChecked = false;
  bool isChecked1 = false;

  String dropdownValue = 'Surat';
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  List<String> hobbylist = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: t1,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: 'Enter Your Name',
                  ),
                ),
              ),
            ),
            Container(
              child: GFCard(
                content: Row(
                  children: [
                    Container(
                      child: Text('Gender       ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Male    '),
                    ),
                    GFRadio(
                      size: GFSize.MEDIUM,
                      activeBorderColor: GFColors.SUCCESS,
                      value: 'Male',
                      groupValue: gender,
                      onChanged: (val) {
                        setState(() {
                          gender = val as String;
                        });
                      },
                      inactiveIcon: null,
                      radioColor: GFColors.SUCCESS,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('         Female  '),
                    ),
                    GFRadio(
                      size: GFSize.MEDIUM,
                      activeBorderColor: GFColors.SUCCESS,
                      value: 'Female',
                      groupValue: gender,
                      onChanged: (val) {
                        setState(() {
                          gender = val as String;
                        });
                      },
                      inactiveIcon: null,
                      radioColor: GFColors.SUCCESS,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: GFCard(
                content: Row(
                  children: [
                    Container(
                      child: Text('Hobby      ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Cricket    '),
                    ),
                    GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: GFColors.DANGER,
                      onChanged: (value) {
                        isChecked = value;
                        if (value) {
                          hobbylist.add("Cricket");
                        } else {
                          hobbylist.remove("Cricket");
                        }
                        setState(() {});
                      },
                      value: isChecked,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('   Music'),
                    ),
                    GFCheckbox(
                      size: GFSize.SMALL,
                      activeBgColor: GFColors.DANGER,
                      onChanged: (value) {
                        isChecked1 = value;
                        if (value) {
                          hobbylist.add("Music");
                        } else {
                          hobbylist.remove("Music");
                        }
                        setState(() {});
                      },
                      value: isChecked1,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text('City',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.arrow_forward_ios),
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue as String;
                    });
                  },
                  items: [
                    'Surat',
                    'Ahmedabad',
                    'Rajkot',
                    'Goa',
                    'Amreli',
                    'Mumbai',
                    'Delhi'
                  ].map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.remove_red_eye_outlined),
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                ),
              ),
            ),
            GFButton(
              onPressed: () {
                String name = t1.text;
                String password = t2.text;

                String hobby = hobbylist.join("/");

                insertData(name, password, gender, hobby, dropdownValue);
              },
              text: "SUBIMT",
              shape: GFButtonShape.pills,
              blockButton: true,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return loginscreen();
                    },
                  ));
                },
                child: Text("Back to login"))
          ],
        ),
      ),
    );
  }

  insertData(String name, String password, String gender, String hobby,
      String city) async {
    var url =
        Uri.parse('http://venerating-radiator.000webhostapp.com/register.php');

    Map m = {
      'name': name,
      'password': password,
      'gender': gender,
      'hobby': hobby,
      'city': city
    };

    var response = await http.post(url, body: m);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String str = response.body;

    if (str == "1") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Inserted")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data Not Inserted"),
          action: SnackBarAction(
            onPressed: () {
              insertData(name, password, gender, hobby, city);
            },
            label: "Try Again",
          ),
        ),
      );
    }
  }
}
