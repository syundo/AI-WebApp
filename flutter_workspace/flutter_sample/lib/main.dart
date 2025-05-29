import 'package:flutter/material.dart';
import 'package:flutter_sample/widgets/column_widget.dart';
import 'package:flutter_sample/widgets/floating_action_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FloatingActionButtonExample(),
        ),
      ),
    );
  }
}