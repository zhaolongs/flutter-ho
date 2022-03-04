import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/25.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单
class TagImagePage extends StatefulWidget {
  @override
  _TagImagePageState createState() => _TagImagePageState();
}

class _TagImagePageState extends State<TagImagePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("目标页面"),
      ),
      backgroundColor: Colors.blueGrey,

      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
            ],
          )),
    );
  }

}