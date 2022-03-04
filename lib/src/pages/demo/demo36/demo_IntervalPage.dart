
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
///
///
///
///
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoIntervalPage(),
  ));
}

class DemoIntervalPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DemoIntervalPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  //旋转动画
  late Animation<double> rotateAnimation;

  //平移
  late Animation<Offset> slideAnimation;

  late Animation<Offset> slideAAnimation;
  late Animation<double> rotateAAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //动画控制器
    _animationController = new AnimationController(
      vsync: this,
      //动画时间
      duration: Duration(milliseconds: 3400),
    );

    //橙色小球使用旋转动画   0.0 ~ 1.0
    rotateAnimation =
        Tween<double>(begin: 0, end: 4).animate(_animationController);
    //蓝色小球使用旋转动画  0.5 ~ 1.0
    rotateAAnimation = Tween<double>(begin: 0, end: 4).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0),
      ),
    );

    slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(4, 0),
    ).animate(_animationController);

    slideAAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(4, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interval")),
      body: Center(
        child: Row(
          children: [
            SlideTransition(
              position: slideAAnimation,
              child: RotationTransition(
                turns: rotateAAnimation,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
            ),
            SlideTransition(
              position: slideAnimation,
              child: RotationTransition(
                turns: rotateAnimation,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    "2",
                    style: TextStyle(color: Colors.white),
                  ),
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _animationController.forward();
        },
        child: Icon(Icons.ac_unit),
      ),
    );
  }
}
