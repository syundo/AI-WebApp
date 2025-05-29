import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'list_students.dart';

class EditStudent extends StatefulWidget{

  int id;
  EditStudent({required this.id});

  @override
  State<StatefulWidget> createState() {
    return _EditStudent();
  }
}

class _EditStudent extends State<EditStudent>{
  
  TextEditingController name = TextEditingController();
  TextEditingController rollno = TextEditingController();
  TextEditingController address = TextEditingController();


  @override
  void initState() {

    Future.delayed(Duration(milliseconds: 500), () async {

      final url = Uri.parse(
        'http://10.0.2.2:8081/demo/read/'+widget.id.toString(),
      );
      final response = await http.get(url);

        var data =json.decode(response.body);
        if(data != null){
            name.text = data["name"];
            rollno.text = data["rollno"].toString();
            address.text = data["address"];
            setState(() {});
        }else{
           print("No any data with roll no: " + widget.id.toString());
        }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text("Edit Student"),
              // automaticallyImplyLeading: false,
            ),
            body:Container( 
               padding: EdgeInsets.all(30),
               child: Column(children: [
                   TextField(
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
                     final url = Uri.parse(
                       'http://10.0.2.2:8081/demo/modify/'+widget.id.toString(),
                     );
                     Map<String, String> headers = {
                       'Content-Type' : 'application/json'
                     };
                     final response = await http.put(url,headers:headers,
                         body: json.encode({
                       "name":name.text, "rollno":rollno.text, "address":address.text
                     }));

                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Data Updated")));

                     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                           return ListStudents();
                     }));

                   }, child: Text("Update Student Data")),
               ],),
            )
       );
  }

}