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
    home: DemoPositionedTransition(),
  ));
}

///代码清单
class DemoPositionedTransition extends StatefulWidget {
  @override
  _DemoPositionedTransitionState createState() =>
      _DemoPositionedTransitionState();
}

class _DemoPositionedTransitionState extends State<DemoPositionedTransition>
    with SingleTickerProviderStateMixin {
  // 0.0 ~ 1.0 默认
  late AnimationController _animationController;
  late Animation<RelativeRect> rectAnimation;
  @override
  void initState() {
    super.initState();
    // 0.0 ~ 1.0 默认
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    rectAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(100, 100, 10, 10),
      end: RelativeRect.fromLTRB(10, 10, 100, 100),
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PositionedTransition")),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          color: Colors.grey[200],
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: Colors.blue,
                width: 100,
                height: 100,
              ),
              PositionedTransition(
                rect: rectAnimation,
                child: Container(
                  color: Colors.orange,
                  width: 66,
                  height: 66,
                ),
              ),
            ],
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
