import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///代码清单
class DemoStatefulBuilderPage extends StatelessWidget {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //状态构建器
      body: buildStatefulBuilder(),
    );
  }

  StatefulBuilder buildStatefulBuilder() {
    return StatefulBuilder(
      //构建状态改变的Widget
      builder: (BuildContext context, void Function(void Function()) setState) {
        //居中
        return Center(
          //手势识别
          child: GestureDetector(
            child: Text("早起的年轻人 $_count"),
            //单击事件
            onTap: () {
              //刷新当前  StatefulBuilder 中的状态
              setState(() {
                _count++;
              });
            },
          ),
        );
      },
    );
  }
}
