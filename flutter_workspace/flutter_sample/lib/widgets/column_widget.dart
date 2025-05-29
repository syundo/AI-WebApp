import 'package:flutter/material.dart';

class ColumnWidgetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            // 주축 정렬 지정
            mainAxisAlignment: MainAxisAlignment.center,
            // 반대축 정렬 지정
            crossAxisAlignment: CrossAxisAlignment.center,
            // 넣고 싶은 위젯 입력
            children: [
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.deepPurple,
              ),
              // SizedBox는 일반적으로 공백을 생성할 때 사용
              const SizedBox(width: 12.0, height: 30),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.green,
              ),
              const SizedBox(width: 12.0, height: 30),
              Container(
                height: 50.0,
                width: 50.0,
                color: Colors.blue,
              )
            ]
          )
        )
      )
    );
  }
}