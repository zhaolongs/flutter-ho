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
class BWidget extends StatefulWidget {
  @override
  _BWidgetState createState() => _BWidgetState();
}

class _BWidgetState extends State<BWidget> {
  int _result = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Container(
      color: Colors.blue,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              _result++;
              //发送数据
              abStreamController.add(_result);
            },
            child: StreamBuilder(
              stream: abStreamController.stream,
              initialData: _result,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Text("++ ${snapshot.data}");
              },
            ),
          ),
        ],
      ),
    );
  }
}
