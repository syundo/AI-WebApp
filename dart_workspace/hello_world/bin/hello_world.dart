import 'package:hello_world/hello_world.dart' as hello_world;

printInter(int aNumber) {
  print('The number is $aNumber.');
}

Future checkVersion() async {
  var version = await lookUpVersion();
  print(version);
}

int lookUpVersion() {
  return 12;
}

Future<String> getVersionName() async {
  return 'Android Q';
}

void printOne() {
  print('one');
}

void printThree() {
  print('three');
}

void printTwo() async {
  Future.delayed(Duration(seconds: 1), () {
    print('two');
  });
}

void main(List<String> arguments) {
  // var number = 42;
  // printInter(number);
  // checkVersion();
  // print('end process');
  // getVersionName()의 리턴값이 넘어오면 후속작업이 이루어짐
  getVersionName().then((value) => {
    print(value)
  });
  print('end process');
}