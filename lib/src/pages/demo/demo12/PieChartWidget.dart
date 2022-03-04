import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/number_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestPage(),
  ));
}

///代码清单
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<double> angles;

  late List<Color> colors;
  late List<String> contents;
  @override
  void initState() {
    super.initState();
    colors = [
      Colors.red,
      Colors.cyan,
      Colors.black,
      Colors.yellow,
      Colors.grey
    ];
    angles = [1 / 7, 2 / 7, 2 / 7, 1 / 14, 3 / 14];
    contents = ["梁朝伟", "刘德华", "郭富城", "周星驰", "张学友"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              PieChartWidget(angles, colors,
                  startTurns: .0, radius: 130, contents: contents)
            ],
          )),
    );
  }
}

class PieChartWidget extends StatefulWidget {
  ///比例集合

  List<double> proportions;

  ///文案集合

  List<String> contents;

  ///颜色集合

  List<Color> colors;

  double startTurns = .0;
  double radius = 130;

  PieChartWidget(this.proportions, this.colors,
      {required this.contents, required this.radius, required this.startTurns});

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget>
    with TickerProviderStateMixin {
  ///这个是 自动
  late AnimationController autoAnimationController;

  late Animation<double> tween;

  double turns = .0;

  GlobalKey _key = GlobalKey();

  ///角加速度，类似摩擦力 的作用 ，让惯性滚动 减慢，这个意思是每一秒 ，角速度 减慢vA个pi。
  double vA = 40.0;

  late Offset offset;

  late double pBy;

  late double pBx;

  late double pAx;

  late double pAy;

  late double mCenterX;
  late double mCenterY;

  late Animation<double> _valueTween;

  late double animalValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2 * widget.radius,
      height: 2 * widget.radius,
      child: GestureDetector(
        child: CustomPaint(
          painter: PieChartPainter(turns, widget.startTurns, widget.proportions,
              widget.colors, widget.contents, _key),
          key: _key,
        ),
        onPanEnd: _onPanEnd,
        onPanDown: _onPanDown,
        onPanUpdate: _onPanUpdate,
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    pBx = details.globalPosition.dx;

    //后面的 点的 x坐标
    pBy = details.globalPosition.dy;

    //后面的点的 y坐标

    double dTurns = getTurns();

    setState(() {
      turns += dTurns;
    });

    pAx = pBx;
    pAy = pBy;
  }

  void _onPanDown(DragDownDetails details) {
    if (offset == null) {
      //获取position
      RenderBox box = _key.currentContext!.findRenderObject() as RenderBox;
      offset = box.localToGlobal(Offset.zero);
      mCenterX = offset.dx + 130;
      mCenterY = offset.dy + 130;
    }

    pAx = details.globalPosition.dx; //初始的点的 x坐标
    pAy = details.globalPosition.dy; //初始的点的 y坐标
  }

  double getTurns() {
    ///计算 之前的点相对于水平的 角度
    ///
    ///
    /// o点（offset.dx+130,offset.dy+130）.
    /// C点 （offset.dx+260,offset.dy+130）.
    /// oc距离  130
    ///
    /// A点 （pAx,pAy）,
    /// B点  (pBx,pBy).
    /// AC距离
    double acDistance = RadianUtils.distanceForTwoPoint(
        offset.dx + 2 * widget.radius, offset.dy + widget.radius, pAx, pAy);

    /// AO距离
    double aoDistance = RadianUtils.distanceForTwoPoint(
        offset.dx + widget.radius, offset.dy + widget.radius, pAx, pAy);

    ///计算 cos aoc 的值 ，然后拿到 角 aoc
    ///
    double ocdistance = widget.radius;

    int c = 1;

    if (pAy < (offset.dy + widget.radius)) {
      c = -1;
    }

    double cosAOC = (aoDistance * aoDistance +
            ocdistance * ocdistance -
            acDistance * acDistance) /
        (2 * aoDistance * ocdistance);
    double AOC = c * acos(cosAOC);

    /// BC距离
    double bcDistance = RadianUtils.distanceForTwoPoint(
        offset.dx + 2 * widget.radius, offset.dy + widget.radius, pBx, pBy);

    /// BO距离
    double boDistance = RadianUtils.distanceForTwoPoint(
        offset.dx + widget.radius, offset.dy + widget.radius, pBx, pBy);

    c = 1;
    if (pBy < (offset.dy + widget.radius)) {
      c = -1;
    }

    ///计算 cos boc 的值，然后拿到角 boc；
    double cosBOC = (boDistance * boDistance +
            ocdistance * ocdistance -
            bcDistance * bcDistance) /
        (2 * boDistance * ocdistance);
    double BOC = c * acos(cosBOC);

    return BOC - AOC;
  }

  ///抬手的时候 ， 惯性滑动
  void _onPanEnd(DragEndDetails details) {
    double vx = details.velocity.pixelsPerSecond.dx;
    double vy = details.velocity.pixelsPerSecond.dy;
    if (vx != 0 || vy != 0) {
      onFling(vx, vy);
    }
  }

  void onFling(double velocityX, double velocityY) {
    //获取触点到中心点的线与水平线正方向的夹角
    double levelAngle = RadianUtils.getPointAngle(mCenterX, mCenterY, pBx, pBy);
    //获取象限
    int quadrant = RadianUtils.getQuadrant(pBx - mCenterX, pBy - mCenterY);
    //到中心点距离
    double distance =
        RadianUtils.distanceForTwoPoint(mCenterX, mCenterY, pBx, pBy);
    //获取惯性绘制的初始角度
    double inertiaInitAngle = RadianUtils.calculateAngleFromVelocity(
        velocityX, velocityY, levelAngle, quadrant, distance);

    if (inertiaInitAngle != null && inertiaInitAngle != 0) {
      //如果角速度不为0； 则进行滚动

      /// 按照 va的加速度 拿到 滚动的时间 。 也就是 结束后 惯性动画的 执行 时间， 高中物理
      double t = inertiaInitAngle.abs() / vA;
      double s = t * inertiaInitAngle / 2;

      animalValue = turns;
      var time = new DateTime.now();
      int direction = 1;

      ///方向控制参数
      if (inertiaInitAngle < 0) {
        direction = -1;
      }
      autoAnimationController = AnimationController(
          duration: Duration(milliseconds: (t * 1000).toInt()), vsync: this)
        ..addListener(() {
          var animalTime = new DateTime.now();
          int t1 =
              animalTime.millisecondsSinceEpoch - time.millisecondsSinceEpoch;
          setState(() {
            double s1 = (2 * inertiaInitAngle - direction * vA * (t1 / 1000)) *
                t1 /
                (2 * 1000);
            turns = animalValue + s1;
          });
        });

      autoAnimationController.forward();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (autoAnimationController != null) {
      autoAnimationController.dispose();
    }
  }
}

class PieChartPainter extends CustomPainter {
  GlobalKey _key = GlobalKey();

  double turns = .0;
  double startTurns = .0;

  List<String> contents;

  PieChartPainter(this.turns, this.startTurns, this.angles, this.colors,
      this.contents, this._key);

  List<double> angles;

  List<Color> colors;

  double startAngles = 0;

  @override
  void paint(Canvas canvas, Size size) {
    drawAcr(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void drawAcr(Canvas canvas, Size size) {
    startAngles = 0;

    /// 中心
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    //画扇形
    for (int i = 0; i < angles.length; i++) {
      paint..color = colors[i];
      canvas.drawArc(rect, 2 * pi * startAngles + turns + startTurns,
          2 * pi * angles[i], true, paint);
      startAngles += angles[i];
    }

    startAngles = 0;

    for (int i = 0; i < contents.length; i++) {
      canvas.save();

      // 新建一个段落建造器，然后将文字基本信息填入;
      ParagraphBuilder pb = ParagraphBuilder(ParagraphStyle(
        textAlign: TextAlign.left,
        fontWeight: FontWeight.w300,
        fontStyle: FontStyle.normal,
        fontSize: 15.0,
      ));
      pb.pushStyle(ui.TextStyle(color: Colors.white));
      double roaAngle =
          2 * pi * (startAngles + angles[i] / 2) + turns + startTurns;

      pb.addText(contents[i]);
      // 设置文本的宽度约束
      ParagraphConstraints pc = ParagraphConstraints(width: 400);
      // 这里需要先layout,将宽度约束填入，否则无法绘制
      Paragraph paragraph = pb.build()..layout(pc);
      // 文字左上角起始点
      Offset offset = Offset(60, 0 - paragraph.height / 2);
      canvas.translate(size.width / 2, size.height / 2);

      canvas.rotate((1) * roaAngle);

      canvas.drawParagraph(paragraph, offset);

      canvas.restore();
      startAngles += angles[i];
    }
  }
}
