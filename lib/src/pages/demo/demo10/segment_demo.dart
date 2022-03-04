import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/17/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SegmentPage(),
  ));
}

class SegmentPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SegmentPageState();
  }
}

class _SegmentPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分段控件"),
      ),

      ///填充布局
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 3,
            ),
            // buildSegment(),
            buildSlidSegment(),
          ],
        ),
      ),
    );
  }

  buildSegment() {
    return CupertinoSegmentedControl(
      //子标签
      children: <int, Widget>{
        0: Text("全部"),
        1: Text("收入"),
        2: Text("支出 "),
      },
      //当前选中的索引
      groupValue: _currentIndex,
      //点击回调
      onValueChanged: (int index) {
        print("当前选中 $index");
        setState(() {
          _currentIndex = index;
        });
      },
      //选中的背景颜色
      selectedColor: Colors.blue,
      //未选中的背景颜色
      unselectedColor: Colors.white,
      //边框颜色
      borderColor: Colors.blue,
      //按下的颜色
      pressedColor: Colors.blue.withOpacity(0.4),
    );
  }

  //当前选中的索引
  int _currentIndex = 0;

  buildSlidSegment() {
    return Container(
      margin: EdgeInsets.only(top: 80),
      width: 300,
      child: CupertinoSlidingSegmentedControl(
        //子标签
        children: <int, Widget>{
          0: Text("全部"),
          1: Text("收入"),
          2: Text("支出 "),
        },
        //当前选中的索引
        groupValue: _currentIndex,
        //点击回调
        onValueChanged: (int? index) {
          print("当前选中 $index");
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
      ),
    );
  }
}
