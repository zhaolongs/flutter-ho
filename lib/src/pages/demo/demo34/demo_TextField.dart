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
    home: DemoTextFieldPage(),
  ));
}

///代码清单
class DemoTextFieldPage extends StatefulWidget {
  @override
  _DemoTextFieldPageState createState() => _DemoTextFieldPageState();
}

class _DemoTextFieldPageState extends State<DemoTextFieldPage> {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("这里是首页")),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
            ),
            SizedBox(
              height: 33,
            ),
            ElevatedButton(onPressed: () {}, child: Text("动态设置"))
          ],
        ),
      ),
    );
  }
}
