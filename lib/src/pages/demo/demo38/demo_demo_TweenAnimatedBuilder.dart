import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    home: DemoAnimatedTweenPage(),
  ));
}

///代码清单
class DemoAnimatedTweenPage extends StatefulWidget {
  @override
  _DemoAnimatedTweenPageState createState() => _DemoAnimatedTweenPageState();
}

class _DemoAnimatedTweenPageState extends State<DemoAnimatedTweenPage> {
  bool _isLock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // ignore: unnecessary_new
            Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
              return DoorLock();
            }));
          },
          child: Text("打开新页面"),
        ),
      ),
    );
  }
}

class DoorLock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 2000),
        tween: Tween<double>(begin: 0, end: 1.0),
        builder: (BuildContext context, double value, Widget? child) {
          return Opacity(
            opacity: value,
            child: Padding(
              padding: EdgeInsets.only(top: 40 * value),
              child: child,
            ),
          );
        },
        child: Image.asset(
          "assets/images/sp02.png",
          width: 200,
          height: 100,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
