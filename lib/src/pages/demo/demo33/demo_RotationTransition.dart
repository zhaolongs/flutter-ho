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
    home: DemoRotationTransition(),
  ));
}

///代码清单
class DemoRotationTransition extends StatefulWidget {
  @override
  _DemoRotationTransitionState createState() => _DemoRotationTransitionState();
}

class _DemoRotationTransitionState extends State<DemoRotationTransition>
    with SingleTickerProviderStateMixin {
  // 0.0 ~ 1.0 默认
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 0.0 ~ 1.0 默认
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 0.5).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RotationTransition")),
      body: Center(
        //缩放动画
        child: RotationTransition(
          //旋转中心配制
          // Alignment.centerLeft 左居中
          alignment: Alignment.centerLeft,
          //0.0~1.0 旋转了 360度
          // rotated v * 2 * pi
          // 0.5 * 2 * pi = 180 度
          turns: _animation,
          child: Container(
            color: Colors.blue,
            height: 100,
            width: 200,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("开始"),
        onPressed: () {
          //动画未执行时状态 AnimationStatus.dismissed
          if (_animationController.status == AnimationStatus.dismissed) {
            //正向执行动画
            _animationController.forward();
          } else if (_animationController.status == AnimationStatus.completed) {
            // AnimationStatus.completed 动画已正向执行完毕状态

            //反向执行动画
            _animationController.reverse();
          }
        },
      ),
    );
  }
}
