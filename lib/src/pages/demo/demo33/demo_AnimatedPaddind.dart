import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    home: DemoAnimatedAnimatedPadding(),
  ));
}

///代码清单
class DemoAnimatedAnimatedPadding extends StatefulWidget {
  @override
  _DemoAnimatedAnimatedPaddingState createState() =>
      _DemoAnimatedAnimatedPaddingState();
}

class _DemoAnimatedAnimatedPaddingState
    extends State<DemoAnimatedAnimatedPadding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedPadding")),
      body: Center(
        child: GestureDetector(
          child: AnimatedPadding(
            child: Text("早起的年轻人"),
            //动画执行完成回调
            onEnd: () {},
            curve: Curves.decelerate,
            padding: EdgeInsets.only(left: 32, right: 22),
            duration: Duration(seconds: 2),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
