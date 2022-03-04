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
    home: DemoSlideTransition(),
  ));
}

///代码清单
class DemoSlideTransition extends StatefulWidget {
  @override
  _DemoSlideTransitionState createState() => _DemoSlideTransitionState();
}

class _DemoSlideTransitionState extends State<DemoSlideTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );
    _animation = Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 0.5))
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SlideTransition")),
      body: Center(
        child: SlideTransition(
          position: _animation,
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
          //动画状态
          AnimationStatus animationStatus = _animationController.status;
          //AnimationStatus.dismissed  未开始执行
          if (animationStatus == AnimationStatus.dismissed) {
            _animationController.forward(from: 0);
          } else if (animationStatus == AnimationStatus.forward) {
            //执行中
          } else if (animationStatus == AnimationStatus.completed) {
            //执行完成  正向执行

            //反向开始执行
            _animationController.reverse();
          } else if (animationStatus == AnimationStatus.reverse) {
            //执行完成 逆向

            _animationController.forward(from: 0);
          }
        },
      ),
    );
  }
}
