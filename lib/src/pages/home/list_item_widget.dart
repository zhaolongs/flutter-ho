import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/play/video_details_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/14.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class ListViewItemWidget extends StatefulWidget {
  final StreamController streamController;
  final isScroll;

  ListViewItemWidget({this.streamController, this.isScroll = false});

  @override
  _ListViewItemWidgetState createState() => _ListViewItemWidgetState();
}

class _ListViewItemWidgetState extends State<ListViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [Icon(Icons.one_k), Text("早起的年轻人")],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 220,
            child: buildVideoWidget(),
          )
        ],
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
    return VideoDetailsWidget(
      streamController: widget.streamController,
    );
  }
}
