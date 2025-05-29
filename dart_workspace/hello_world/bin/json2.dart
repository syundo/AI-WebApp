import 'dart:convert';

var scores = [
  {'score':40},
  {'score':80},
  {'score':100,'overtime':true,'special_guest':null}
];

void main() {
  var jsonText = jsonEncode(scores); // json으로 인코딩
  print(jsonText=='[{"score":40},{"score":80},{"score":100,"overtime":true,"special_guest":null}]'); // true
  print(scores is List); // []는 List
  print(scores[0] is Map); // {}는 Map
}