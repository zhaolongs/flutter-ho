import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlowFliterWidget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/2/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginHouCheDemoPage(),
  ));
}

///代码清单
class LoginHouCheDemoPage extends StatefulWidget {
  @override
  _LoginHouCheDemoPageState createState() => _LoginHouCheDemoPageState();
}

class _LoginHouCheDemoPageState extends State<LoginHouCheDemoPage>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController _animationController;

  double _flagValue = 0.0;

  int _clickFlag = 0;

  /// 0.0~1.0
  double _topValue = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 400));
    _animationController.addListener(() {
      if (_clickFlag == 1) {
        //值从 0.0 ~ 1.0
        _topValue = 0.0;
        _flagValue = _animationController.value;
      } else if (_clickFlag == 2) {
        _flagValue = 0.0;
        _topValue = _animationController.value;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      //背景
      backgroundColor: Colors.grey,
      body: buildBodyFunction(),
    );
  }

  buildBodyFunction() {
    return Stack(
      children: [
        //顶部的占位
        Positioned(
          top: 20,
          left: 60,
          right: 60,
          height: 60,
          child: GestureDetector(
            onTap: () {
              _clickFlag = 2;
              _animationController.reset();
              _animationController.forward();
            },
            child: FlowFliterWidget(
              flag: 0.5,
            ),
          ),
        ),
        //底部的占位
        Positioned(
          //向上移动
          top: 220,
          // 60 ~ 40
          left: 60,
          // 60 ~ 40
          right: 60,
          //60 ~ 70
          height: 60,
          child: GestureDetector(
              onTap: () {
                _clickFlag = 1;
                _animationController.reset();
                _animationController.forward();
              },
              child: FlowFliterWidget(
                flag: 0.5,
              )),
        ),

        Positioned(
          top: 20 + 100 * _topValue,
          left: 60 - 40 * _topValue,
          right: 60 - 40 * _topValue,
          height: 60 + 10 * _topValue,
          child: GestureDetector(
            onTap: () {
              _clickFlag = 2;
              _animationController.reset();
              _animationController.forward();
            },
            child: FlowFliterWidget(
              flag: 0.5 - 0.5 * _topValue,
            ),
          ),
        ),
        //下面的
        Positioned(
          //向上移动
          top: 220 - 100 * _flagValue,
          // 60 ~ 40
          left: 60 - 40 * _flagValue,
          // 60 ~ 40
          right: 60 - 40 * _flagValue,
          //60 ~ 70
          height: 60 + 10 * _flagValue,
          child: GestureDetector(
              onTap: () {
                _clickFlag = 1;
                _animationController.reset();
                _animationController.forward();
              },
              child: FlowFliterWidget(
                flag: 0.5 - 0.5 * _flagValue,
              )),
        ),
        //中间的
        Positioned(
          //120~20
          top: 120 - 100 * _flagValue + 100 * _topValue,
          //20~60
          left: 20 + 40 * _flagValue + 40 * _topValue,
          //20~60
          right: 20 + 40 * _flagValue + 40 * _topValue,
          height: 70 - 10 * _flagValue - 10 * _topValue,
          child: GestureDetector(
            onTap: () {
              if (_clickFlag == 2) {
                _clickFlag = 1;
                _animationController.reset();
                _animationController.forward();
              } else if (_clickFlag == 1) {
                _clickFlag = 2;
                _animationController.reset();
                _animationController.forward();
              }
            },
            child: FlowFliterWidget(
              flag: 0.5 * _flagValue,
            ),
          ),
        ),
      ],
    );
  }
}
