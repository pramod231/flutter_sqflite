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
  TextEditingController updateTitleCon = TextEditingController();
  TextEditingController updateDesCon = TextEditingController();
  
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
                // height: width*0.15 ,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  // boxShadow: [
                  //   BoxShadow(color: Colors.green, spreadRadius: 3),
                  // ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: width*0.65,
                          // color: Colors.redAccent,
                          child: Text(
                            '${_journals[index]['title']}',
                            textScaleFactor: 1.4,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          width: width*0.65,
                          // color: Colors.redAccent,
                          child: Text(
                            'Status : ${_journals[index]['description']}',
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: (){
                        upadteItem(index+1);
                          },
                          child: Icon(Icons.edit),
                        ),
                         Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: InkWell(
                            onTap: () async{
                              await SqlHelper.deleteItems(index+1);
                              _refreshJournols();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Icon(Icons.delete),
                            ),
                          ),
                        )
                      ],
                    ),

                  ],
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
        child: Center(child: Text("Add Task",style: TextStyle(color: Colors.white,fontSize: 15),)),
      ),
    );
  }

  void upadteItem(int id) {

    print("index $id");
    final existingJournal = _journals.firstWhere((element) => element['id']==id);
    updateTitleCon.text = existingJournal['title'];
    updateDesCon.text = existingJournal['description'];

    double width = MediaQuery. of(context). size. width ;
    double height = MediaQuery. of(context). size. height;
    showDialog(context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Center(child: const Text('Update Task',style: TextStyle(fontSize: 15),)),
          actions: <Widget>[
            Column(
              children:  [
                Container(
                  padding: EdgeInsets.only(top:10,left: 15,right: 15,),
                  child: TextField(
                    controller: updateTitleCon,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                      hintText: 'Enter Title',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  child: TextField(
                    controller: updateDesCon,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Status',
                      hintText: 'Enter Status',
                    ),
                  ),
                ),
                InkWell(
                  onTap: ()  async {
                    await SqlHelper.updateItems(id, updateTitleCon.text, updateDesCon.text);
                    _refreshJournols();
                    Navigator.pop(context);
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
                    child: Center(child: Text("Update Task",style: TextStyle(color: Colors.white,fontSize: 15),)),
                  ),
                )

              ],
            ),
          ],
        ));
  }
}
