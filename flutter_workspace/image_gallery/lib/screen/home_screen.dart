import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// ❷ State 정의
class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState(); // ➌ 부모 initState() 실행

    Timer.periodic(
      // ➍ Timer.periodic() 등록
      Duration(seconds: 3),
          (timer) {
        print('실행!');
        int? nextPage = pageController.page?.toInt();

        // ➋
        if (nextPage == null) {
          return;
        }
        // ➌
        if (nextPage == 4) {
          nextPage = 0;
        } else {
          nextPage++;
        }
        pageController.animateToPage(
          // ➍ 페이지 변경
          nextPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: PageView(
          controller: pageController,
          // ➊ PageView 추가
          children: [
            Image.network('https://cdn.pixabay.com/photo/2023/02/14/18/55/flowers-7790227_960_720.jpg',fit: BoxFit.cover, ),
            Image.network('https://cdn.pixabay.com/photo/2023/02/04/09/20/castle-7766794_960_720.jpg',fit: BoxFit.cover, ),
            Image.network('https://cdn.pixabay.com/photo/2023/02/13/18/00/bird-7787970_960_720.jpg',fit: BoxFit.cover, ),
            Image.network('https://cdn.pixabay.com/photo/2022/11/07/14/21/labor-7576514_960_720.jpg',fit: BoxFit.cover, ),
            Image.network('https://cdn.pixabay.com/photo/2022/11/10/20/44/switzerland-7583676__340.jpg',fit: BoxFit.cover, ),
          ] // ➋ 샘플 리스트 생성
      )
    );
  }
}