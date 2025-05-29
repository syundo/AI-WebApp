import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// URI/URL을 생성하는데 도움을 주는 클래스
// localhost 테스트 시 http://10.0.2.2 사용
final uri = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(uri); // ❶ 컨트롤러 변수 생성

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Code Factory'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(uri);
            },
            icon: Icon(
              Icons.home,
            )
          )
        ]
      ),
      body: WebViewWidget(
        // ❷ WebView 추가하기
        controller: controller,
        // initialUrl: 'https://blog.codefactory.ai',
        // javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController controller) {
        //   this.controller = controller; // ➍ 위젯에 컨트롤러 저장
        // },
      )
    );
  }
}