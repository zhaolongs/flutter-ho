import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/demo38/demo_demo_TweenAnimatedBuilder.dart';

import 'index_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单

class RootAPP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootAPPState();
  }
}

class _RootAPPState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          bottomAppBarTheme: BottomAppBarTheme(color: Colors.blue)),
      //不显示 debug 标签
      debugShowCheckedModeBanner: false,
      home: DemoAnimatedTweenPage(),
      // home: IndexPage(),
    );
  }
}
