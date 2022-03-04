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
  //动画控制器
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    //0.0 - 1.0
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
  }

  @override
  Widget build(BuildContext context) {
    //返回
    return Scaffold(
      //按钮
      floatingActionButton: FloatingActionButton(
        //小图标
        child: Icon(Icons.add),
        //点击事件
        onPressed: () {
          _animationController.reset();
          _animationController.forward();
        },
      ),
      appBar: AppBar(
        title: Text("Animated"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        //线性布局
        child: Column(
          children: [
            TransformAnimated(
              animation: _animationController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("测试数据"),
                  Text("测试数据"),
                  Text("测试数据"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TransformAnimated extends AnimatedWidget {
  Widget child;

  TransformAnimated({required this.child, required Animation animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    //获取动画控制监听
    Animation<double>? animation = listenable as Animation<double>?;
    //自定义
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 60 * animation!.value / 2,
      ),
      height: 260,
      //向下平移
      child: Transform.translate(
        // 参数一 表示 在x轴方向的平移量
        // 参数二 表示 在y轴方向的平移量
        offset: Offset(0.0, 150 * animation.value),
        //执行动画的子Widet
        child: child,
      ),
    );
  }
}
