import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ab.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
///
///

///代码清单
class AWidget extends StatefulWidget {
  @override
  _AWidgetState createState() => _AWidgetState();
}

class _AWidgetState extends State<AWidget> {
  int _result = 0;
  late StreamSubscription _streamSubscription;
  @override
  void initState() {
    super.initState();
    //设置一个监听  订阅一个监听
    _streamSubscription = abStreamController.stream.listen((event) {
      _result = event;
      setState(() {});
    });
  }

  @override
  void dispose() {
    //取消订阅
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      color: Colors.blue,
      child: Text("A中的数据 ${_result}"),
    );
  }

  Container buildContainer() {
    return Container(
      color: Colors.blue,
      child: StreamBuilder(
        stream: abStreamController.stream,
        initialData: _result,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          _result = snapshot.data!;
          return Text("A中的数据 ${snapshot.data}");
        },
      ),
    );
  }
}
