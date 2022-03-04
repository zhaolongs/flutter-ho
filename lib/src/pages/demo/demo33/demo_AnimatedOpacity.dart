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
    home: DemoAnimatedOpacity(),
  ));
}

///代码清单
class DemoAnimatedOpacity extends StatefulWidget {
  @override
  _DemoAnimatedOpacityState createState() => _DemoAnimatedOpacityState();
}

class _DemoAnimatedOpacityState extends State<DemoAnimatedOpacity> {
  double _opacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedOpacity(
              //动画时间
              duration: Duration(seconds: 2),
              //透明度
              opacity: _opacity,
              //动画执行结束回调
              onEnd: () {},
              //动画曲线
              curve: Curves.fastOutSlowIn,
              child: Container(
                padding: EdgeInsets.all(20),
                child: FlutterLogo(
                  size: 100,
                ),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _opacity = _opacity == 0.0 ? 1.0 : 0.0;
          });
        },
        child: Text("显示"),
      ),
    );
  }
}
