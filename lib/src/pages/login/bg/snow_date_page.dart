import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/11/22.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂 获取系列课程 ：https://study.163.com/instructor/1021406098.htm
/// 可关注 CSDN 博客：https://blog.csdn.net/zl18603543572
/// 可关注 掘金 博客：https://juejin.cn/post/6900009848973623303
///
/// 西瓜视频 https://www.ixigua.com/home/3662978423
/// 知乎 https://www.zhihu.com/people/zhao-long-90-89
/// 哔哩 https://www.bilibili.com/video/BV1E54y1677c/
///
///
/// 程序入口
void main() {
  runApp(
    MaterialApp(
      //不显示debug标签
      debugShowCheckedModeBanner: false,
      //默认显示的首页面
      home: SnowWidget(),
    ),
  );
}

/// 雪花背景
class SnowWidget extends StatefulWidget {
  @override
  _SnowWidgetState createState() => _SnowWidgetState();
}

//全局定义获取颜色的方法
Color getRandomWhiteColor(Random random) {
  //透明度 0 ~ 200  255是不透明
  int a = random.nextInt(200);
  return Color.fromARGB(a, 255, 255, 255);
}

class _SnowWidgetState extends State<SnowWidget> with TickerProviderStateMixin {
  //创建一个集合用来保存气泡
  List<BobbleBean> _list = [];

  //随机数
  Random _random = new Random(DateTime.now().microsecondsSinceEpoch);

  //来个动画控制器
  AnimationController _animationController;

  //初始化函数中创建气泡
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initData();
    });

    //创建动画控制器 1秒
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));

    //执行刷新监听
    _animationController.addListener(() {
      setState(() {});
    });
    //开启气泡的运动
    _animationController.repeat();

    // 状态栏隐藏
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  void initData() {
    for (int i = 0; i < 2000; i++) {
      BobbleBean bean = new BobbleBean();
      //获取随机透明度白色
      bean.color = getRandomWhiteColor(_random);
      //设置位置 先来个默认的 绘制的时候再修改
      double x = _random.nextDouble() * MediaQuery.of(context).size.width;
      double y = _random.nextDouble() * MediaQuery.of(context).size.height;
      double z = _random.nextDouble() + 0.5;
      bean.speed = _random.nextDouble() + 0.01 / z;
      bean.postion = Offset(x, y);
      bean.origin = Offset(x, 0);
      //设置半径
      bean.radius = 2.0 / z;

      _list.add(bean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
        width: double.infinity,
        height: double.infinity,
        //层叠布局
        child: Stack(
          children: [
            //第一部分 背景
            Positioned.fill(
              child: Image.asset(
                "assets/images/bg_snow.png",
                fit: BoxFit.fill,
              ),
            ),
            //第二部分 雪花
            CustomPaint(
              size: MediaQuery.of(context).size,
              //画布
              painter: SnowCustomMyPainter(list: _list, random: _random),
            ),
          ],
        ),
      ),
    );
  }

}

///创建画布
class SnowCustomMyPainter extends CustomPainter {
  List<BobbleBean> list;
  Random random;

  SnowCustomMyPainter({this.list, this.random});

  //先来个画笔
  Paint _paint = new Paint()..isAntiAlias = true;
  //具体的绘制功能
  @override
  void paint(Canvas canvas, Size size) {
    // 在绘制前重新计算每个点的位置
    list.forEach((element) {
      //左右微抖动
      double dx = random.nextDouble() * 2.0 - 1.0;
      //竖直方向位置偏移
      double dy = element.speed;
      //位置偏移量计算
      element.postion += Offset(dx, dy);

      //重置位置
      if (element.postion.dy > size.height) {
        element.postion = element.origin;
      }

    });
    //
    // //绘制
    list.forEach((element) {
      //修改画笔的颜色
      _paint.color = element.color;
      //绘制圆
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  //刷新 控制
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //返回false 不刷新
    return true;
  }
}

///气泡模型 基本属性信息
class BobbleBean {
  //位置
  Offset postion;
  //初始位置
  Offset origin;
  //颜色
  Color color;
  //运动的速度
  double speed;
  //半径
  double radius;
}
