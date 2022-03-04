import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bubble_bean.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/4.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///绘制气泡的画布
///lib/src/page/login/bg/bubble_painter.dart
class CustomMyPainter extends CustomPainter {
  //创建画笔
  Paint _paint = Paint();
  //保存气泡的集合
  List<BobbleBean> list;
  //随机数变量
  Random random;
  CustomMyPainter({required this.list, required this.random});

  ///计算坐标
  Offset calculateXY(double speed, double theta) {
    return Offset(speed * cos(theta), speed * sin(theta));
  }

  @override
  void paint(Canvas canvas, Size size) {
    //每次绘制都重新计算位置
    list.forEach((element) {
      //计算偏移
      var velocity = calculateXY(element.speed, element.theta);
      //新的坐标 微偏移
      var dx = element.postion.dx + velocity.dx;
      var dy = element.postion.dy + velocity.dy;
      //x轴边界计算
      if (element.postion.dx < 0 || element.postion.dx > size.width) {
        dx = random.nextDouble() * size.width;
      }
      //y轴边界计算
      if (element.postion.dy < 0 || element.postion.dy > size.height) {
        dy = random.nextDouble() * size.height;
      }
      //新的位置
      element.postion = Offset(dx, dy);

      //print("dx $dx dy $dy  ${element.postion}");
    });

    //循环绘制所有的气泡
    list.forEach((element) {
      //画笔颜色
      _paint.color = element.color;
      //绘制圆
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
