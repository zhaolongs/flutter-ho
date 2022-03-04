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
    home: DemoAnimatedDefaultTextStylePage(),
  ));
}

///代码清单
class DemoAnimatedDefaultTextStylePage extends StatefulWidget {
  @override
  _DemoAnimatedDefaultTextStylePageState createState() =>
      _DemoAnimatedDefaultTextStylePageState();
}

class _DemoAnimatedDefaultTextStylePageState
    extends State<DemoAnimatedDefaultTextStylePage> {
  bool _select = false;
  TextStyle _style = TextStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Center(
        child: AnimatedDefaultTextStyle(
          duration: Duration(seconds: 2),
          style: _style,
          child: Text(
            "早起的年轻人",
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (!_select) {
            _style = TextStyle(
                fontSize: 16,
                color: Colors.orange,
                fontWeight: FontWeight.w600);
          } else {
            _style = TextStyle(fontSize: 22, color: Colors.green);
          }
          _select = !_select;
          setState(() {});
        },
      ),
    );
  }
}
