import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/MyHomeOage.dart';
import 'package:flutter_hive/SqlHelper.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController amountCon = TextEditingController();
  TextEditingController categoryCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Add Task"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children:  [
          Container(
            padding: EdgeInsets.only(top: 80,left: 15,right: 15,),
            child: TextField(
              controller: categoryCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Category',
                hintText: 'Enter Category',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: TextField(
              controller: descriptionCon,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'description',
                hintText: 'Enter description',
              ),
            ),
          ),
          // Container(
          //   padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          //   child: TextField(
          //     controller: amountCon,
          //     obscureText: true,
          //     decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'amount',
          //       hintText: 'Enter amount',
          //     ),
          //   ),
          // ),
          InkWell(
            onTap: ()  {

              addItems();
            },
            // splashColor: Colors.redAccent,
            child: Container(
              // margin: EdgeInsets.only(bottom: 18,left: 10,right: 10),
              margin: EdgeInsets.all(10),
              height: 55,
              width: width*0.9,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(child: Text("Add Expenses",style: TextStyle(color: Colors.white,fontSize: 15),)),
            ),
          )

        ],
      ),
    );
  }

  Future<void> addItems() async {
    await  SqlHelper.createItem(categoryCon.text, descriptionCon.text);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MyHomePage()));
  }
}
