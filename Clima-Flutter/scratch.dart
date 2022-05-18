import 'dart:io';

void main() {
  performTasks();
}

void performTasks() {
  tastk1();
  tastk2();
  tastk3();
}

void tastk1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> tastk2() async {
  Duration threeSeconds = Duration(seconds: 3);

  String result;
  await Future.delayed(threeSeconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
}

void tastk3() {
  String result = 'task 3 data';
  print('Task 3 complete');
}
