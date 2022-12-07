import 'package:flutter_test/flutter_test.dart';

void main() {
  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  list.where((element){
    print("where($element)");
    return element > 5;
  }).forEach((element) {
    print("forEach($element)");
  });
/*final future = Future.delayed(const Duration(seconds: 1));
  test("test with for loop", () async {
    for(var i in list) {
      await future;
      print(i);
    }

    print("hello");
  });*/
}