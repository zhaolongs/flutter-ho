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
    home: DemoRelativePositionedTransition(),
  ));
}

///代码清单
class DemoRelativePositionedTransition extends StatefulWidget {
  @override
  _DemoRelativePositionedTransitionState createState() =>
      _DemoRelativePositionedTransitionState();
}

class _DemoRelativePositionedTransitionState
    extends State<DemoRelativePositionedTransition>
    with SingleTickerProviderStateMixin {
  // 0.0 ~ 1.0 默认
  late AnimationController _animationController;
  late Animation<Rect> rectAnimation;

  @override
  void initState() {
    super.initState();
    // 0.0 ~ 1.0 默认
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    rectAnimation = CustomRectTween(
      begin: Rect.fromCircle(center: Offset(0, 0), radius: 20),
      end: Rect.fromCircle(center: Offset(0, 0), radius: 420),
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RelativePositionedTransition")),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          color: Colors.grey[200],
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final Size biggest = constraints.biggest;
              return Stack(
                alignment: Alignment.center,
                children: [
                  RelativePositionedTransition(
                    rect: rectAnimation,
                    size: biggest,
                    child: Container(
                      color: Colors.orange,
                      width: 66,
                      height: 66,
                    ),
                  ),
                ],
              );
            },
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

class CustomRectTween extends Tween<Rect> {
  /// Creates a [Rect] tween.
  ///
  /// The [begin] and [end] properties may be null; the null value
  /// is treated as an empty rect at the top left corner.
  CustomRectTween({Rect? begin, Rect? end}) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  Rect lerp(double t) => Rect.lerp(begin, end, t) ?? Rect.zero;
}
