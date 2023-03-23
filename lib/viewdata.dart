import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loginpage/student.dart';

class data extends StatefulWidget {
  const data({Key? key}) : super(key: key);

  @override
  State<data> createState() => _dataState();
}

class _dataState extends State<data> {
  int t = 0;
  List<Data> l = [];

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    var url = Uri.parse('http://192.168.29.182/demo/viewdata.php');

    var response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> m = jsonDecode(response.body);

    student S = student.fromJson(m);

    if (S.add == 1) {
      l = S.data!;
    }
    setState(() {
      status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Data m = l[index];
                    return ListTile(
                      leading: Text("${m.id}"),
                      title: Text("${m.name}"),
                      subtitle: Text("${m.password}"),
                    );
                  },
                )
              : Center(child: Text("no data found")))
          : Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            if (value == 0) {
              l.sort((a, b) => a.name!.compareTo(b.name!));
            }
            if (value == 1) {
              l.sort((b, a) => a.name!.compareTo(b.name!));
            }
            if (value == 2) {
              l.sort((a, b) => a.password!.compareTo(b.password!));
            }
            if (value == 3) {
              l.sort((b, a) => a.password!.compareTo(b.password!));
            }
            setState(() {
              t = value;
            });
          },
          currentIndex: t,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.amber,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.sort), label: 'atoz'),
            BottomNavigationBarItem(icon: Icon(Icons.sort), label: 'ztoa'),
            BottomNavigationBarItem(icon: Icon(Icons.sort), label: 'ltoh'),
            BottomNavigationBarItem(icon: Icon(Icons.sort), label: 'htol')
          ]),
    );
  }
}
