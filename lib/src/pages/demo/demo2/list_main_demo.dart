import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/demo2/list_demo2_item_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/27.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(
    MaterialApp(
      home: ListDemo2Page(),
    ),
  );
}

///代码清单
class ListDemo2Page extends StatefulWidget {
  @override
  _ListDemo2PageState createState() => _ListDemo2PageState();
}

class _ListDemo2PageState extends State<ListDemo2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("测试Demo"),
      ),
      backgroundColor: Colors.white,
      // Alt + 回车键提示
      //Ctrl + Alt + L 格式化代码
      //Ctrl + E 显示最近编辑的文件列表
      body: ListView.builder(
        //条目个数
        itemCount: 10,
        //每个子条目的样式
        itemBuilder: (BuildContext context, int index) {
          return ListViewDemo2Item(index: index,);
        },
      ),
    );
  }
}
