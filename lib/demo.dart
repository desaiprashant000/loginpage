import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

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
          ElevatedButton(onPressed: () async {
            String name = t1.text;
            String password = t2.text;

            insertData(name, password);
          }, child: Text('Submit')),
        ],
      ),
    );
  }

  insertData(String name, String password) async {
    var url = Uri.parse('http://192.168.29.182/demo/ragister.php');

    Map m = {'name': name, 'password': password};
    var response = await http.post(url, body: m);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    String str = response.body;

    if (str != "1") {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Inserted")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Data Not Inserted"),
          action: SnackBarAction(
            onPressed: () {
              insertData(name, password);
            },
            label: "Try Again",
          )));
    }
  }

}
