import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FlowItemWidget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/2/13.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class FlowFliterWidget extends StatefulWidget {
  final double flag;

  const FlowFliterWidget({Key? key, this.flag = 0.0}) : super(key: key);

  @override
  _FlowFliterWidgetState createState() => _FlowFliterWidgetState();
}

class _FlowFliterWidgetState extends State<FlowFliterWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FlowItemWidget(),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 0.4, sigmaX: 0.4),
            child: Container(
              color: Colors.grey.withOpacity(widget.flag),
            ),
          ),
        ),
      ],
    );
  }
}
