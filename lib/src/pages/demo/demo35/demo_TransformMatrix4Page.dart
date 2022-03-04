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
    home: DemoTransformImagePage(),
  ));
}

class DemoTransformImagePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DemoTransformImagePage> {

  double x = 0;
  double y = 0;
  double z = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Transform")),
      body: Center(
        child: Transform(
          transform: Matrix4(
            1,0,0,0,
            0,1,0,0,
            0,0,1,0,
            0,0,0,1,
          )
            ..rotateZ(z)
            ..rotateX(x)
            ..rotateY(y)
            ..setEntry(3, 0, 0.0)
            ..setEntry(3, 1, -0.006),
          alignment: FractionalOffset.center,
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details){
              setState(() {
                y = y - details.delta.dx / 100;
                x = x + details.delta.dy / 100;
              });
            },
            child: Container(
              color: Colors.red,
              height: 200.0,
              width: 200.0,
            ),
          ),
        ),
      ),
    );
  }
}
