import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/demo22/demo_LoadingWidget.dart';

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
    home: DemoBackdropFilterPage(),
  ));
}

///代码清单
class DemoBackdropFilterPage extends StatefulWidget {
  @override
  _DemoBackdropFilterPageState createState() => _DemoBackdropFilterPageState();
}

class _DemoBackdropFilterPageState extends State<DemoBackdropFilterPage> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      // _isLoading=false;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("高斯模糊"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          //居中
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/sp05.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned.fill(
              child: buildLoading(),
            ),
          ],
        ),
      ),
    );
  }

  buildLoading() {
    if (!_isLoading) {
      return Container();
    }
    return Stack(
      //居中
      alignment: Alignment.center,
      children: [
        //高斯模糊层
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100),
            child: Container(
              color: Color(0x80ffffff),
            ),
          ),
        ),
        LoadingWidget(
          title: "加载中",
        ),
      ],
    );
  }
}
