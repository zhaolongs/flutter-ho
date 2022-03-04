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
    home: DemoAlignTransition(),
  ));
}

///代码清单
class DemoAlignTransition extends StatefulWidget {
  @override
  _DemoAlignTransitionState createState() => _DemoAlignTransitionState();
}

class _DemoAlignTransitionState extends State<DemoAlignTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<AlignmentGeometry> alignment;
  late Animation<AlignmentGeometry> alignment2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 600));
    alignment =
        Tween<AlignmentGeometry>(begin: Alignment(0, 1), end: Alignment(0, 0))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
    alignment2 =
        Tween<AlignmentGeometry>(begin: Alignment(0, 1), end: Alignment(0, -1))
            .animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AlignTransition")),
      body: Stack(
        children: [
          Positioned(
            bottom: 40,
            right: 20,
            child: Container(
              height: 140,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AlignTransition(
                    alignment: alignment,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("测试三"),
                    ),
                  ),
                  AlignTransition(
                    alignment: alignment2,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("测试二"),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      AnimationStatus status = _animationController.status;
                      if (status == AnimationStatus.completed) {
                        _animationController.reverse();
                      } else {
                        _animationController.forward();
                      }
                    },
                    child: Text("测试一"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
