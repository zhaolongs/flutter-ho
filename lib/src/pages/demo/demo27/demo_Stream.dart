import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'a_widget.dart';
import 'b_widget.dart';

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
    home: DemoStreamPage(),
  ));
}

///代码清单
class DemoStreamPage extends StatefulWidget {
  @override
  _DemoStreamPageState createState() => _DemoStreamPageState();
}

class _DemoStreamPageState extends State<DemoStreamPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Stream"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Container(
            width: 300,
            height: 200,
            child: AWidget(),
          ),
          SizedBox(
            height: 22,
          ),
          Container(
            width: 300,
            height: 200,
            child: BWidget(),
          ),
        ]),
      ),
    );
  }
}
