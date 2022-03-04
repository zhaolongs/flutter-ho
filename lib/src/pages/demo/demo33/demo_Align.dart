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
    home: DemoAlignPage(),
  ));
}

///代码清单
class DemoAlignPage extends StatefulWidget {
  @override
  _DemoAlignPageState createState() => _DemoAlignPageState();
}

class _DemoAlignPageState extends State<DemoAlignPage> {
  //对齐方式
  Alignment _alignment = Alignment.center;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        child: AnimatedAlign(
          alignment: _alignment,
          //动画曲线
          curve: Curves.bounceInOut,
          //动画执行完成
          onEnd: () {
            print("执行结束 ");
          },
          duration: Duration(seconds: 2),
          child: Text(
            "早起的年轻人",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("切换"),
        onPressed: () {
          _alignment = _alignment == Alignment.center
              ? Alignment.topCenter
              : Alignment.center;
          setState(() {});
        },
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "早起的年轻人",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("切换"),
        onPressed: () {},
      ),
    );
  }
}
