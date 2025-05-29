import 'package:flutter/material.dart';
import 'package:flutter_lab/screen/home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home:Scaffold(
            body:Center(
                child:HomeScreen()
            )
        )
    );
  }
}