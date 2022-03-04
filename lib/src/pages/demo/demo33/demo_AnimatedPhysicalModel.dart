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
    home: DemoAnimatedPhysicalModel(),
  ));
}

///代码清单
class DemoAnimatedPhysicalModel extends StatefulWidget {
  @override
  _DemoAnimatedPhysicalModelState createState() =>
      _DemoAnimatedPhysicalModelState();
}

class _DemoAnimatedPhysicalModelState extends State<DemoAnimatedPhysicalModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedPhysicalModel")),
      body: Center(
        child: AnimatedPhysicalModel(
          //阴影的圆角
          borderRadius: BorderRadius.all(Radius.circular(20)),
          //时间
          duration: Duration(seconds: 2),
          //阴影颜色
          shadowColor: Colors.deepPurple,
          //true 启动阴影颜色变化动画
          animateShadowColor: true,
          //背景
          color: Colors.green,
          //阴影高度
          elevation: 22.0,
          //阴影形状
          shape: BoxShape.rectangle,
          //动画执行完成
          onEnd: () {},
          //动画速率
          curve: Curves.bounceInOut,
          child: Container(
            alignment: Alignment.center,
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Text(
              "早起的年轻人",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
