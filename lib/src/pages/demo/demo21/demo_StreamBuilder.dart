import 'dart:async';

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
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoStreamBuilder(),
  ));
}

///代码清单
class DemoStreamBuilder extends StatefulWidget {
  @override
  _DemoStreamBuilderState createState() => _DemoStreamBuilderState();
}

class _DemoStreamBuilderState extends State<DemoStreamBuilder> {

  int _count = 0;
  //流Stream 控制器
  StreamController<int> _streamController = StreamController();

  @override
  void dispose() {
    //销毁
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _count++;
          //发送消息
          _streamController.add(_count);
        },
      ),
      appBar: AppBar(
        title: Text("StreamBuilder"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            //接收消息
            StreamBuilder<int>(
              //初始值
              initialData: _count,
              //绑定Stream
              stream: _streamController.stream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text("测试使用 ${snapshot.data}");
              },
            ),

            Text("测试使用"),
            Text("测试使用"),
          ],
        ),
      ),
    );
  }
}
