import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'list_students.dart';

class AddStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      return _AddStudent();
  }
}

class _AddStudent extends State<AddStudent>{

  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
       return Scaffold(
            appBar: AppBar(
              title: Text("Add Student"),
              //automaticallyImplyLeading: false,
            ),
            body:Container( 
               padding: EdgeInsets.all(30),
               child: Column(children: [
                   TextField(
                     // onChanged: (val){
                     //   print(name.text);
                     //   print(val);
                     //   },
                     controller: name,
                     decoration: InputDecoration(
                        hintText: "Stuent Name",
                     ),
                   ),

                   TextField(
                     controller: rollno,
                     decoration: InputDecoration(
                        hintText: "Roll No.",
                     ),
                   ),

                   TextField(
                     controller: address,
                     decoration: InputDecoration(
                        hintText: "Address:",
                     ),
                   ),

                   ElevatedButton(onPressed: () async {
                        if(name.text.isEmpty){
                          _dialog('name을 입력하세요');
                          return;
                        }
                        if(rollno.text.isEmpty){
                          _dialog('Roll No를 입력하세요');
                          return;
                        }
                        if(address.text.isEmpty){
                          _dialog('address를 입력하세요');
                          return;
                        }

                        Map<String, String> headers = {
                          'Content-Type' : 'application/json'
                        };
                        final url = Uri.parse(
                          'http://10.0.2.2:8081/demo/regist',
                        );
                        await http.post(url,headers: headers,
                            body: json.encode({
                          "name":name.text, "rollno":rollno.text, "address":address.text
                        }));

                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("New Student Added")));

                         name.text = "";
                         rollno.text = "";
                         address.text = "";

                         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                           return ListStudents();
                         }));

                   }, child: Text("Save Student Data")),
               ],),
            )
       );
  }

  _dialog(String msg) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(msg),
                  ],
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }




}