import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginpage/airlines.dart';

class viewdata extends StatefulWidget {
  const viewdata({Key? key}) : super(key: key);

  @override
  State<viewdata> createState() => _viewdataState();
}

class _viewdataState extends State<viewdata> {
  List<air> data = [];
  List<Products> pro = [];

  getdata() async {
    try {
      var response = await Dio().get('https://fakestoreapi.com/carts');
      // print(response);
      List list = response.data;
      // print(list);
      list.forEach((element) {
        // print(element);
        setState(() {
          data.add(air.fromJson(element));
          pro.add(Products.fromJson(element));
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: data.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                air a = data[index];
                return ListTile(
                  title: Text("${a.id}"),
                  subtitle: Text("${a.date}"),
                  leading: Text("${a.products![0].productId}"),
                  trailing: Text("${a.products![0].quantity}"),
                );
              },
              itemCount: data.length,
            )
          : CircularProgressIndicator(),
    );
  }
}
