import 'dart:convert';

void main() {
  var jsonString = '''
  [
    {"score":40},
    {"score":80} 
  ]
  ''';

  var scores = jsonDecode(jsonString); // json으로 인코딩
  print(scores is List); // true
  var firstScore = scores[0]; // 첫번째 점수
  print(firstScore is Map); // true
  print(firstScore['score']==40); // true
}