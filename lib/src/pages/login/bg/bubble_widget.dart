import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/color_utils.dart';

import 'bubble_bean.dart';
import 'bubble_painter.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/4.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///气泡动画背景
class BubbleWidget extends StatefulWidget {
  @override
  _BubbleWidgetState createState() => _BubbleWidgetState();
}

class _BubbleWidgetState extends State<BubbleWidget>
    with SingleTickerProviderStateMixin {
  //创建的气泡保存集合
  List<BobbleBean> _list = [];

  //随机数据
  Random _random = new Random(DateTime.now().microsecondsSinceEpoch);

  //气泡的最大半径
  double maxRadius = 100;

  //气泡动画的最大速度
  double maxSpeed = 0.7;

  //气泡计算使用的最大弧度（360度）
  double maxTheta = 2.0 * pi;

  //动画控制器
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < 20; i++) {
      BobbleBean particle = new BobbleBean();
      //获取随机透明度的白色颜色
      particle.color = ColorUtils.getRandonWhightColor(_random);
      //指定一个位置 每次绘制时还会修改
      particle.postion = Offset(-1, -1);
      //气泡运动速度
      particle.speed = _random.nextDouble() * maxSpeed;
      //随机角度
      particle.theta = _random.nextDouble() * maxTheta;
      //随机半径
      particle.radius = _random.nextDouble() * maxRadius;
      //集合保存
      _list.add(particle);
    }

    //动画控制器
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    //刷新监听
    _animationController.addListener(() {
      //流更新
      setState(() {});
    });

    Future.delayed(Duration(milliseconds: 200), () {
      _animationController.repeat();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      //自定义画布
      painter: CustomMyPainter(
        list: _list,
        random: _random,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
