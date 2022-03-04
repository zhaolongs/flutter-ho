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
    home: DemoSizeTransition(),
  ));
}

///代码清单
class DemoSizeTransition extends StatefulWidget {
  @override
  _DemoSizeTransitionState createState() => _DemoSizeTransitionState();
}

class _DemoSizeTransitionState extends State<DemoSizeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SizeTransition")),
      body: Center(
        child: SizeTransition(
          //偏移量
          axisAlignment: 1.0,
          //动画控制
          sizeFactor: _animationController,
          axis: Axis.vertical,
          child: buildContainer(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("开始"),
        onPressed: () {
          _animationController.forward(from: 0);
        },
      ),
    );
  }

  Container buildContainer() {
    return Container(
      //子Widget 对齐方式
      alignment: Alignment.center,
      width: 300,
      //高度
      height: 200,
      //背景颜色
      color: Colors.blue,
      child: Text(
        "早起的年轻人",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
