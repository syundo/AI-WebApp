import 'package:class_test/class_test.dart' as class_test;


class Car {
  int? maxSpeed;
  num? price;
  String? name;

  // 생성자. field 초기화.
  Car(int this.maxSpeed, num this.price, String this.name);

  num?  saleCar() {
    price = price! * 0.9;
    return price;
  }
}

void main(List<String> arguments) {
  Car bmw = Car(320, 100000, 'BMW');
  Car toyota = Car(250, 70000, 'BENZ');
  Car ford = Car(200, 80000, 'FORD');
  bmw.saleCar();
  bmw.saleCar();
  bmw.saleCar();
  print(bmw.price);
}