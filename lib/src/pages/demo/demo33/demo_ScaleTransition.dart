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
    home: DemoScaleTransition(),
  ));
}

///代码清单
class DemoScaleTransition extends StatefulWidget {
  @override
  _DemoScaleTransitionState createState() => _DemoScaleTransitionState();
}

class _DemoScaleTransitionState extends State<DemoScaleTransition>
    with SingleTickerProviderStateMixin {
  late Animation<double> scaleAnimation;

  // 0.0 ~ 1.0 默认
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // 0.0 ~ 1.0 默认
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    scaleAnimation = new Tween<double>(begin: 1.0, end: 0.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ScaleTransition")),
      body: Center(
        //缩放动画
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            color: Colors.blue,
            height: 200,
            width: 200,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("开始"),
        onPressed: () {
          if (_animationController.status == AnimationStatus.dismissed) {
            _animationController.forward();
          } else if (_animationController.status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      ),
    );
  }
}
