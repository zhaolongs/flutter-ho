import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/11.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

main() {
  runApp(MaterialApp(
    home: SignSwiperPage(),
  ));
}

class SignSwiperPage extends StatefulWidget {
  @override
  _SignSwiperPageState createState() => _SignSwiperPageState();
}

class _SignSwiperPageState extends State<SignSwiperPage>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    //创建
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    //添加到事件队列中
    Future.delayed(Duration.zero, () {
      //动画重复执行
      _animationController.repeat();
    });
  }

  @override
  void dispose() {
    //销毁
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swiper Demo"),
      ),
      backgroundColor: Colors.white,
      //居中
      body: Center(
        //层叠布局
        child: Stack(
          children: [
            //第一层的背景 圆形剪裁
            ClipOval(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.green,
              ),
            ),
            //第二层的扫描
            buildRotationTransition(),
          ],
        ),
      ),
    );
  }

  RotationTransition buildRotationTransition() {
    //旋转动画
    return RotationTransition(
      //动画控制器
      turns: _animationController,
      //圆形裁剪
      child: ClipOval(
        //扫描渐变
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            //扫描渐变
            gradient: SweepGradient(colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.6),
            ]),
          ),
        ),
      ),
    );
  }
}
