import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    home: DemoMouseRegionPage(),
  ));
}

///代码清单
class DemoMouseRegionPage extends StatefulWidget {
  @override
  _DemoMouseRegionPageState createState() => _DemoMouseRegionPageState();
}

class _DemoMouseRegionPageState extends State<DemoMouseRegionPage> {
  //为true时鼠标进入了监听区域中
  bool _isEnter = false;
  //绑定文本框，用来获取文本Text的位置与大小信息
  GlobalKey _globalKey = GlobalKey();
  //文本颜色
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: Text("MouseRegion"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //鼠标事件监听
            buildMouseRegion(),
          ],
        ),
      ),
    );
  }

  MouseRegion buildMouseRegion() {
    return MouseRegion(
      //进入
      onEnter: (PointerEnterEvent event) {
        print("进入 ---");
        setState(() {
          _isEnter = true;
        });
      },
      //退出
      onExit: (PointerExitEvent event) {
        print("退出 ---");
        setState(() {
          _isEnter = false;
        });
      },
      onHover: (PointerHoverEvent event) {
        //x 当前鼠标位置
        buildHoverEvent(event);
      },
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        height: 300,
        child: Text(
          "这是什么 ？？？",
          key: _globalKey,
          style: TextStyle(color: _textColor),
        ),
        color: _isEnter ? Colors.blueAccent : Colors.blue[200],
      ),
    );
  }

  void buildHoverEvent(PointerHoverEvent event) {
    //x 当前鼠标位置
    double x = event.position.dx;
    double y = event.position.dy;
    RenderObject? renderObject = _globalKey.currentContext!.findRenderObject();
    //获取文本组件的属性信息
    RenderBox? renderBox = renderObject as RenderBox?;
    //文本组件的左上角点坐标
    Offset offset = renderBox!.localToGlobal(Offset.zero);

    double topX = offset.dx;
    double topY = offset.dy;

    //文本组件的大小
    Size size = renderBox.paintBounds.size;

    //文本组件的右下角点坐标
    double bottomX = topX + size.width;
    double bottomY = topY + size.height;

    if (x > topX && x < bottomX && y > topY && y < bottomY) {
      //在文本组件 Text 的区域内 文字颜色为红色
      _textColor = Colors.red;
    } else {
      _textColor = Colors.black;
    }
    setState(() {});
    print("onHover --- $x  $y  $offset");
  }
}
