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
    home: DemoAnimatedPositionedDirectionalPage(),
  ));
}

///代码清单
class DemoAnimatedPositionedDirectionalPage extends StatefulWidget {
  @override
  _DemoAnimatedPositionedDirectionalPageState createState() =>
      _DemoAnimatedPositionedDirectionalPageState();
}

class _DemoAnimatedPositionedDirectionalPageState
    extends State<DemoAnimatedPositionedDirectionalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Directionality(
          // TextDirection.ltr  left to right  从左到右
          //  TextDirection.rtl rtl right to left
          textDirection: TextDirection.ltr,
          child: Stack(
            children: [
              AnimatedPositionedDirectional(
                top: 100,
                start: 300,
                width: 100,
                height: 200,
                duration: Duration(seconds: 2),
                //执行结束回调
                onEnd: () {},
                //动画曲线
                curve: Curves.fastOutSlowIn,
                child: Container(
                  color: Colors.blue,
                  child: Text("早起的年轻人"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
