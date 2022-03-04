import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/17/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TipsDemoPage(),
  ));
}

class TipsDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TipsDemoPageState();
  }
}

class _TipsDemoPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("控件"),
      ),

      ///填充布局
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tooltip(
              message: "小提示",
              //true 显示在下面，false 显示在上面
              preferBelow: true,
              //显示的时间
              showDuration: Duration(seconds: 3),
              //内边距
              padding: EdgeInsets.only(left: 20, right: 20),
              //垂直偏移
              verticalOffset: 10.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Colors.white,
              ),
              textStyle: TextStyle(color: Colors.blue),
              //外边距
              margin: EdgeInsets.only(top: 10, left: 60),
              child: ElevatedButton(
                onPressed: () {},
                child: Text("想一想"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
