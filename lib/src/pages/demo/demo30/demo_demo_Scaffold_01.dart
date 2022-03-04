import 'package:flutter/cupertino.dart';
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
          print("点击了 FloatingActionButton");
        },

        ///长按提示
        tooltip: "点击了 tooltip s ",

        ///设置悬浮按钮的背景
        backgroundColor: Colors.red,

        ///获取焦点时显示的颜色
        focusColor: Colors.green,

        ///鼠标悬浮在按钮上时显示的颜色
        hoverColor: Colors.yellow,

        ///水波纹颜色
        splashColor: Colors.deepPurple,

        ///定义前景色 主要影响文字的颜色
        foregroundColor: Colors.black,

        ///配制阴影高度 未点击时
        elevation: 0.0,

        ///配制阴影高度 点击时
        highlightElevation: 20.0,
        mini: true,
      ),

      ///用来控制  FloatingActionButton 的位置
      ///FloatingActionButtonLocation.endFloat 右下角 默认 浮动
      ///FloatingActionButtonLocation.endDocked 右下角 无浮动效果 无间隔
      ///FloatingActionButtonLocation.endTop 右上角
      ///
      /// FloatingActionButtonLocation.centerDocked 居中（底部）） 无浮动效果 无间隔
      /// FloatingActionButtonLocation.centerFloat 居中（底部） 浮动
      ///FloatingActionButtonLocation.centerTop 居中（顶部） 浮动
      ///
      /// FloatingActionButtonLocation.startTop 顶部 左对齐
      /// FloatingActionButtonLocation.startFloat 左下角 浮动
      ///  FloatingActionButtonLocation.startFloat 左下角 不浮动

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
