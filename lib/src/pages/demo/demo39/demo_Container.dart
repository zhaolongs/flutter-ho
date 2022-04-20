import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'demo_Container2.dart';
import 'demo_Container3.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoViewPaddingPage(),
  ));
}

///代码清单
class DemoAnimatedSwitcherLockPage extends StatefulWidget {
  @override
  _DemoAnimatedSwitcherLockPageState createState() =>
      _DemoAnimatedSwitcherLockPageState();
}

class _DemoAnimatedSwitcherLockPageState
    extends State<DemoAnimatedSwitcherLockPage> {
  bool _isLock = false;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: buildText(),
      ),
    );
  }











  Widget buildText() {
    return  Container(
      //内边距
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      //边框背景装饰
      decoration:  BoxDecoration(
        //背景颜色
          color: Colors.grey,
          //边框
          border: Border.all(color: Colors.red,width: 1.0),
          //边框圆角
          borderRadius: BorderRadius.all(Radius.circular(22))),
      child: const Text("早起的年轻人"),
    );
  }












}
