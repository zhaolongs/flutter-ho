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
    home: DemoPositionedPage(),
  ));
}

///代码清单
class DemoPositionedPage extends StatefulWidget {
  @override
  _DemoPositionedPageState createState() => _DemoPositionedPageState();
}

class _DemoPositionedPageState extends State<DemoPositionedPage> {
  double _top = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedPositioned(
              top: 400,
              left: 100,
              //动画时间
              duration: Duration(seconds: 2),
              //动画曲线
              curve: Curves.bounceIn,
              onEnd: () {
                print("动画执行完成");
              },
              child: Text(
                "早起的年轻人",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("切换"),
        onPressed: () {
          setState(() {
            _top += 20;
          });
        },
      ),
    );
  }
}
