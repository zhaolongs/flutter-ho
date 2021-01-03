import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_art_list_item_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/3.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HomeItem3Page extends StatefulWidget {
  @override
  _HomeItem3PageState createState() => _HomeItem3PageState();
}

class _HomeItem3PageState extends State<HomeItem3Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的文章列表"),
      ),
      backgroundColor: Color(0XffCDDEEC),
      //懒加载
      body: ListView.builder(
        //列表的个数
        itemCount: 120,
        //列表的每个子Item 的样式
        itemBuilder: (BuildContext context, int index) {
          return HomeItemArtWidget();
        },
      ),
    );
  }
}
