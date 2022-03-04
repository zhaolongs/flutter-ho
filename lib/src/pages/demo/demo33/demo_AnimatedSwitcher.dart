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
    home: DemoAnimatedSwitcher(),
  ));
}

///代码清单
class DemoAnimatedSwitcher extends StatefulWidget {
  @override
  _DemoAnimatedSwitcherState createState() => _DemoAnimatedSwitcherState();
}

class _DemoAnimatedSwitcherState extends State<DemoAnimatedSwitcher>
    with TickerProviderStateMixin {
  double _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedSwitcher")),
      body: Center(
        child: buildChild(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("开始"),
        onPressed: () {
          setState(() {
            _count++;
          });
        },
      ),
    );
  }

  List<String> _imageList = [
    "assets/images/banner1.png",
    "assets/images/banner2.png",
    "assets/images/banner3.png",
  ];

  buildChild() {
    return AnimatedSwitcher(
      duration: Duration(seconds: 1),
      //动画构建
      transitionBuilder: (Widget child, Animation<double> animation) {
        //左进左出
        Tween<Offset> tween =
            Tween(begin: Offset(-1, 0), end: Offset(0.0, 0.0));

        return SlideTransition(
          position: tween.animate(animation),
          child: child,
        );
      },
      child: Image.asset(
        _imageList[(_count % 3).toInt()],
        key: UniqueKey(),
      ),
    );
  }
}

class SlideLeftToRightWidget extends AnimatedWidget {
  SlideLeftToRightWidget({
    required Animation<Offset> postionAnimation,
    required this.child,
  }) : super(listenable: postionAnimation);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animation<Offset> postionAnimation = listenable as Animation<Offset>;

    Offset offset = postionAnimation.value;

    //获取下动画状态
    if (postionAnimation.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, -offset.dy);
    }

    return FractionalTranslation(
      translation: offset,
      child: child,
    );
  }
}
