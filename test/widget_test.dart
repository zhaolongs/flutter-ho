// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {


    //通过毫秒定义
    Duration duration = new Duration(milliseconds: 2000);
    //通过秒定义
    Duration duration2 = new Duration(seconds: 2);

    //创建计时器
    Timer timer = Timer(duration, (){
      //延时回调
    });

    Future.delayed(duration,(){
      //延时回调
    });
  });
}
