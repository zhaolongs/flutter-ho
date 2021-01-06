import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'banner_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/6.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HomeItemDemoPage extends StatefulWidget {
  @override
  _HomeItemDemoPageState createState() => _HomeItemDemoPageState();
}

class _HomeItemDemoPageState extends State<HomeItemDemoPage> {


  List<String> _list =[
    "assets/images/banner1.png",
    "assets/images/banner1.png",
    "assets/images/banner1.png",
    "assets/images/banner1.png",
    "assets/images/banner1.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              BannerWidget(imageList: _list,),
            ],
          )),
    );
  }

}
