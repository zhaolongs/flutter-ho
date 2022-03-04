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
///
///
///
///
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoColorTweenPage(),
  ));
}

class DemoColorTweenPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DemoColorTweenPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //创建动画控制器
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    //添加动画执行刷新监听
    _animationController.addListener(() {
      setState(() {});
    });
    //添加动画状态监听
    _animationController.addStatusListener((status) {
      //获取动画执行状态
      AnimationStatus status = _animationController.status;

      //动画正向执行完成状态
      if (status == AnimationStatus.completed) {
        //反向开启动画
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //动画初始未执行或者是动画反向执行完成

        //正向开始执行动画
        _animationController.forward();
      }
    });
    //颜色动画变化
    _animation = ColorTween(begin: Colors.blue, end: Colors.red)
        .animate(_animationController);

    //添加到事件队列
    Future.delayed(Duration.zero, () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tween")),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: _animation.value,
        ),
      ),
    );
  }
}
