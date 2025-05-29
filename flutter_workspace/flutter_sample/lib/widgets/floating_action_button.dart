import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatingActionButtonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          // 클릭했을 때 실행할 함수
          onPressed: () {
            print('클릭됨');
          },
          child: Text('클릭')
        ),
        body: Container()
      ),
    );
  }
}