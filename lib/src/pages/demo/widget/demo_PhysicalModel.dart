import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoPhysicalModel(),
  ));
}

///代码清单
class DemoPhysicalModel extends StatefulWidget {
  @override
  _DemoPhysicalModelState createState() => _DemoPhysicalModelState();
}

class _DemoPhysicalModelState extends State<DemoPhysicalModel> {
  int _currentIndex = 0;
  Color _shadowColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PhysicalModel 自定义阴影"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: buildAnimatedPhysicalModel(),
      ),
    );
  }

  AnimatedPhysicalModel buildAnimatedPhysicalModel() {
    return AnimatedPhysicalModel(
      //阴影的圆角
      borderRadius: BorderRadius.all(Radius.circular(0)),
      //阴影形状 默认矩形
      shape: BoxShape.rectangle,
      //背景颜色
      color: Colors.transparent,
      animateColor: true,
      //阴影颜色
      shadowColor: _shadowColor,
      animateShadowColor: true,
      //阴影高度 默认为0
      elevation: 1.0,
      //动态切换的时间
      duration: Duration(milliseconds: 1200),
      child: Text("早起的年轻人"),
    );
  }

  ///[PhysicalModel]的基本使用
  Widget buildPhysicalModel() {
    return PhysicalModel(
      //阴影的圆角
      borderRadius: BorderRadius.all(Radius.circular(10)),
      //阴影形状 默认矩形
      shape: BoxShape.rectangle,
      //背景颜色
      color: Colors.deepPurple,
      //阴影颜色
      shadowColor: Colors.orange,
      //阴影高度 默认为0
      elevation: 20.0,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
      ),
    );
  }
}
