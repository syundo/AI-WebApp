import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_student.dart';
import 'edit_student.dart';


class ListStudents extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _ListStudents();
  }

}

class _ListStudents extends State<ListStudents>{

  List slist = [];

  TextEditingController name = TextEditingController();

  @override
  void initState() {
    getdata();
  }

  Future getdata() async{
    final url = Uri.parse(
      'http://10.0.2.2:8081/demo/list',
    );
    final response = await http.get(url);
    this.setState(() {
      slist = json.decode(response.body);
    });
  }

  Future search() async{
    final url = Uri.parse(
      'http://10.0.2.2:8081/demo/search/'+name.text,
    );
    final response = await http.get(url);
    this.setState(() {
      slist = json.decode(response.body);
    });
  }


  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
           title: Text("List of Students"),
           // automaticallyImplyLeading: false,
           actions: [
              IconButton(
                icon: Icon(Icons.save_as),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return AddStudent();
                  }));
                },
              ),
             IconButton(
               icon: Icon(Icons.search),
               onPressed: () {
                 _dialog('name: ');
               },
             ),
            ]
        ),
        body: SingleChildScrollView(
          child:
          Container(
             alignment: Alignment.center,
             child: slist.length == 0?Text("data not found"):
             Column( 
                children: slist.map((stuone){
                     return Card(
                       child: ListTile(
                          leading: Icon(Icons.people),
                          title: Text(stuone["name"]),
                          subtitle: Text("Roll No:" + stuone["rollno"].toString() + ", Add: " + stuone["address"]),
                          trailing: Wrap(children: [

                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                                    return EditStudent(id: stuone["id"]);
                                }));
                              }, icon: Icon(Icons.edit)),


                              IconButton(onPressed: () async {
                                final url = Uri.parse(
                                  'http://10.0.2.2:8081/demo/delete/'+stuone["id"].toString(),
                                );
                                await http.delete(url);

                                print("Data Deleted");
                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Deleted")));
                                   getdata();
                              }, icon: Icon(Icons.delete, color:Colors.red))


                          ],),
                       ),
                     );
                }).toList(),
             ), 
          ),
        ),
     );
  }

  _dialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Search"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(msg),
                    Expanded(child:TextField(
                      controller: name,
                      decoration: InputDecoration(
                        hintText: "name",
                      ),
                    ),
                    ),

                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    search();
                    Navigator.of(context).pop();
                  },
                  child: Text("Search"))
            ],
          );
        });
  }

}
