import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UpdateScreen extends StatefulWidget {
  final int id;
  const UpdateScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  TextEditingController amountCon = TextEditingController();
  TextEditingController categoryCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Update Task"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children:  [
          Container(
            padding: EdgeInsets.only(top: 80,left: 15,right: 15,),
            child: TextField(
              controller: categoryCon,
              obscureText: true,
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
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'description',
                hintText: 'Enter description',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child: TextField(
              controller: amountCon,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'amount',
                hintText: 'Enter amount',
              ),
            ),
          ),
          InkWell(
            onTap: ()  {

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
}
