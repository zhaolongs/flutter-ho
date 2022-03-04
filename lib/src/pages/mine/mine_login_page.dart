import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///用户未登录的用户中心
class MineLoginPage extends StatefulWidget {
  @override
  _MineLoginPageState createState() => _MineLoginPageState();
}

class _MineLoginPageState extends State<MineLoginPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Color(0XffCDDEEC),
      ),
      child: Scaffold(
        //填充布局
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: buildStack()),
      ),
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        Positioned.fill(child: buildBackgroundWidget()),
      ],
    );
  }

  Container buildBackgroundWidget() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.lightBlueAccent.withOpacity(0.3),
            Colors.blue.withOpacity(0.3),
          ])),
    );
  }
}
