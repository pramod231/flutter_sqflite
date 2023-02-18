import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive/SqlHelper.dart';
import 'package:flutter_hive/UpdateScreen.dart';

import 'AddScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Map<String,dynamic>> _journals = [];
  var isLoading = true;

  void _refreshJournols() async{
    final data = await SqlHelper.getItems();
    setState(() {
      _journals = data;
      isLoading = false;
    });
  }


  @override
  void initState() {
    _refreshJournols();
    print("NUMVER of items ${_journals.length}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;

    return Scaffold(
      bottomNavigationBar: getBottomButton(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading ? Center(child: Text("Loading..."),):_journals.length != 0 ?getList(): Center(child: Text("No Data..."),),
    );
  }

  getList() {
    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;

    return SafeArea(
        child: ListView.builder(
          itemCount:_journals.length,
            itemBuilder: (BuildContext context, index){
              return Container(
                height: width*0.15 ,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width*0.65,
                      // color: Colors.redAccent,
                      child: Text(
                        '${_journals[index]['title']}',
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateScreen(index)));
                          },
                          child: Icon(Icons.edit),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: InkWell(
                            child: Icon(Icons.delete),
                          ),
                        )
                      ],
                    ),

                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.green, spreadRadius: 3),
                  // ],
                ),
              );
            }
            )
    );
  }

  getBottomButton() {
    double width = MediaQuery. of(context). size. width ;
    return InkWell(
      onTap: () async {


        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddScreen()));

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
    );
  }
}
