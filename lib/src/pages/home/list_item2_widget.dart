import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/play/video_details2_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/14.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class ListViewItem2Widget extends StatefulWidget {
  final StreamController streamController;
  final isScroll;

  ListViewItem2Widget({required this.streamController, this.isScroll = false});

  @override
  _ListViewItem2WidgetState createState() => _ListViewItem2WidgetState();
}

class _ListViewItem2WidgetState extends State<ListViewItem2Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Container(
        height: 220,
        child: buildVideoWidget(),
      ),
    );
  }

  Widget buildVideoWidget() {
    if (widget.isScroll) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/images/welcome.png",
          fit: BoxFit.fitWidth,
        ),
      );
    }
    return VideoDetails2Widget(
      streamController: widget.streamController,
    );
  }
}
