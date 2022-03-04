import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoAnimatedBuilder(),
  ));
}

///代码清单
class DemoAnimatedBuilder extends StatefulWidget {
  @override
  _DemoAnimatedBuilderState createState() => _DemoAnimatedBuilderState();
}

class _DemoAnimatedBuilderState extends State<DemoAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    //0 -1.0
    _animationController = AnimationController(
        duration: Duration(
          milliseconds: 1000,
        ),
        vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //返回 或者说退出页面里的提示
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _animationController.reset();
          _animationController.forward();
        },
      ),
      appBar: AppBar(
        title: Text("AnimatedBuilder"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            //动画构建器
            AnimatedBuilder(
              //动画控制器
              animation: _animationController,
              //动画布局构建
              builder: (BuildContext context, Widget? child) {
                return Container(
                  margin: EdgeInsets.only(top: 20 * _animationController.value),
                  color: Colors.grey[200],
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Transform.translate(
                    offset: Offset(0.0, 100 * _animationController.value - 100),
                    child: child,
                  ),
                );
              },
              //动画过程中不执行刷新的子Widget
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("测试使用"),
                  Text("测试使用"),
                  Text("测试使用"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
