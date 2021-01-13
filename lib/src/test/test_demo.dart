import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/toast_utils.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/12.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with SingleTickerProviderStateMixin {
  //图片数据
  List<Widget> imageList = [];

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    ///PageView设置滑动监听
    _scrollController.addListener(() {
      //PageView滑动的距离
      setState(() {});
    });
  }

  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Demo"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(),
    );
  }

}
