import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TimerPicker.dart';

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
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoScaffold01Page(),
  ));
}

///代码清单
class DemoScaffold01Page extends StatefulWidget {
  @override
  _DemoScaffold01PageState createState() => _DemoScaffold01PageState();
}

class _DemoScaffold01PageState extends State<DemoScaffold01Page> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (_globalKey.currentContext != null) {
      BuildContext? ctx = _globalKey.currentContext;
      if (ctx != null) {
        RenderObject? renderObject = ctx.findRenderObject();
        if (renderObject != null) {
          RenderObject _renderBox = renderObject;
          Offset centerRightOffset = _renderBox.paintBounds.bottomLeft;
          print("centerRightOffset $centerRightOffset");
        }
      }
    }

    ///使用 Scaffold 组件来构建应用的基本页面
    /// 页面的架构
    return Scaffold(
      ///定义页面的标题
      appBar: AppBar(
        title: Text("这里是首页"),
      ),

      ///定义的页面的主体内容
      ///定义的悬浮按钮
      floatingActionButton: FloatingActionButton(
        key: _globalKey,
        child: Text("++"),

        ///点击响应事
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return TimerPicker(
                  callback: (a) async {
                    print(a);
                  },
                );
              });
        },
      ),
    );
  }
}
