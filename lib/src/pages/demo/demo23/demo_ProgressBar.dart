import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建人： Created by zhaolong

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
    home: DemoBackdropFilterPage(),
  ));
}

///代码清单
class DemoBackdropFilterPage extends StatefulWidget {
  @override
  _DemoBackdropFilterPageState createState() => _DemoBackdropFilterPageState();
}

class _DemoBackdropFilterPageState extends State<DemoBackdropFilterPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  int _currentValue = 0;
  DragController _dragController = new DragController();

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      _currentValue++;
      if (_currentValue >= 100) {
        stopTimer();
        _dragController.start();
      }

      setState(() {});
    });
  }

  void stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> testList = ["test1", "xioming", "张三", "xioming", "张三", "李四"];
    print(testList); //[test1, xioming, 张三, xioming, 张三, 李四]
//将list转为set,将后面重复的都去掉
    Map<int, String> map = testList.asMap();
    print(map); //{0: test1, 1: xioming, 2: 张三, 3: xioming, 4: 张三, 5: 李四}

    //
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startTimer();
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      width: 222,
      height: 222,
      child: CustomProgressWidget(
        progress: _currentValue,
        title: "$_currentValue",
        total: 100,
        controller: _dragController,
      ),
    );
  }

  Widget buildTextField7() {
    return new TextField(
      //设置最大行数为3行
      maxLines: 10,
      //输入文本格式过滤
      inputFormatters: [
        //限制单行
      ],
    );
  }
}

///抽屉状态监听
typedef OpenDragListener = void Function(int value);

///抽屉控制器
class DragController {
  late OpenDragListener _openDragListener;

  ///控制器中添加监听
  setOpenDragListener(OpenDragListener listener) {
    _openDragListener = listener;
  }

  ///打开抽屉
  void update(int progress) {
    if (_openDragListener != null) {
      _openDragListener(progress);
    }
  }

  void start() {
    if (_openDragListener != null) {
      _openDragListener(1);
    }
  }

  void stop() {
    if (_openDragListener != null) {
      _openDragListener(2);
    }
  }
}

class CustomProgressWidget extends StatefulWidget {
  final int progress;
  final int total;

  ///抽屉控制器
  final DragController controller;

  final String title;
  final TextStyle titleStyle;
  final TextStyle subStyle;
  final String subTitle;

  const CustomProgressWidget({
    Key? key,
    this.progress = 0,
    this.total = 100,
    required this.controller,
    this.title = "00",
    this.subTitle = "%",
    this.titleStyle = const TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
    this.subStyle = const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomProgressWidgetState();
  }
}

class _CustomProgressWidgetState extends State<CustomProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.controller != null) {
      widget.controller.setOpenDragListener((int value) {
        if (value == 1) {
          Future.delayed(Duration.zero, () {
            _animationController.repeat();
          });
        } else {
          _animationController.stop();
        }
      });
    }
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
  }

  double _progressStrt = pi / 2 + pi / 5;
  int _currentProgress = 0;

  @override
  void didUpdateWidget(covariant CustomProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _currentProgress = widget.progress;
  }

  @override
  void dispose() {
    _animationController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //居中
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(20),
            child: CustomPaint(
              painter: MyPainter(
                  completePercent: _currentProgress * 1.0,
                  completeColor: Colors.white,
                  completeWidth: 10.0,
                  lineColor: Colors.transparent,
                  lineColors: []),
            ),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 22),
            child: Container(
              color: Color(0x50000000),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(20),
            child: CustomPaint(
                painter: MyPainter(
                  completePercent: _currentProgress * 1.0,
                  width: 0.5,
                  completeWidth: 2.0,
                  lineColor: Colors.deepPurple.withAlpha(200),
                  completeColor: Colors.blue,
                  lineColors: [],
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${widget.title}',
                        style: widget.titleStyle,
                      ),
                      Text(
                        '${widget.subTitle}',
                        style: widget.subStyle,
                      ),
                    ],
                  ),
                )),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(60),
            child: RotationTransition(
              turns: _animation,
              child: CustomPaint(
                painter: MyGradientPainter(
                    start: _progressStrt,
                    width: 6,
                    value: _animationController.value,
                    lineColors: [
                      Colors.deepPurple,
                      Colors.blue,
                      Colors.deepPurple,
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
 * 如果只有一个圆的情况下,请设置已完成的圆  默认的圆的颜色不要设置
 */
class MyPainter extends CustomPainter {
  //默认的线的背景颜色
  Color lineColor;

  //默认的线的宽度
  double width;

  //已完成线的颜色
  Color completeColor;

  //已完成的百分比
  double completePercent;

  //已完成的线的宽度
  double completeWidth;

  // 从哪开始 1从下开始, 2 从上开始 3 从左开始 4 从右开始  默认从下开始
  double startType;

  //是不是虚线的圈
  bool isDividerRound;

  //中间的实圆 统计线条是不是渐变的圆
  bool isGradient;

  //结束的位置
  double endAngle;

  //默认的线的背景颜色
  List<Color> lineColors;

  //实心圆阴影颜色
  // Color shadowColor;
  //渐变圆  深色在下面 还是在左面  默认在下面
  bool isTransfrom;

  MyPainter({
    this.lineColor = Colors.grey,
    this.completeColor = Colors.blue,
    this.completePercent = 80,
    this.width = 1.0,
    this.completeWidth = 2.0,
    this.startType = 2,
    this.isDividerRound = false,
    this.isGradient = false,
    this.endAngle = pi * 2,
    required this.lineColors,
    this.isTransfrom = false,
    // this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    double radius = min(size.width / 2, size.height / 2); //  半径

    //是否有第二层圆
    if (lineColor != null) {
      //是不是 虚线圆
      if (isDividerRound) {
        //背景的线
        Paint line = Paint()
          ..color = lineColor
          // ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..isAntiAlias = true
          ..strokeWidth = width;

        double i = 0.00;
        while (i < pi * 2) {
          canvas.drawArc(Rect.fromCircle(center: center, radius: radius), i,
              0.04, false, line);
          i = i + 0.08;
        }
      } else {
        //背景的线  实线
        Paint line = Paint()
          ..color = lineColor
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = width;

        canvas.drawCircle(
            //  画圆方法
            center,
            radius,
            line);
      }
    }
    //画上面的圆
    if (completeWidth > 0) {
      double arcAngle = 2 * pi * (completePercent / 100);

      // 从哪开始 1从下开始, 2 从上开始 3 从左开始 4 从右开始  默认从下开始
      double start = pi / 2;
      if (startType == 2) {
        start = -pi / 2;
      } else if (startType == 3) {
        start = pi;
      } else if (startType == 4) {
        start = pi * 2;
      }

      //创建画笔
      Paint paint = Paint()
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke
        ..strokeWidth = completeWidth;

      ///是渐变圆
      if (isGradient == true) {
        //渐变圆 深色位置偏移量  默认深色在下面
        double transfrom;
        if (isTransfrom == false) {
          //深色在下面
          transfrom = -pi / 2;
        } else {
          //深色在左面
          transfrom = pi * 2;
        }
        paint.shader = SweepGradient(
          startAngle: 0.0,
          endAngle: pi * 2,
          colors: lineColors,
          tileMode: TileMode.clamp,
          transform: GradientRotation(transfrom),
        ).createShader(
          Rect.fromCircle(center: center, radius: radius),
        );

        canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start,
            arcAngle, false, paint);
      } else {
        ///是实体圆
        paint.color = completeColor;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          start, //  -pi / 2,从正上方开始  pi / 2,从下方开始
          arcAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

///渐变圆
class MyGradientPainter extends CustomPainter {
  //默认的线的背景颜色
  List<Color> lineColors;

  //默认的线的宽度
  double width;
  double endAngle;
  double start;
  double value;

  MyGradientPainter({
    this.start = 0.0,
    required this.lineColors,
    required this.value,
    this.width = 4.0,
    this.endAngle = pi * 2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2); //  坐标中心
    double radius = min(size.width / 2, size.height / 2); //  半径
    var paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = width;
    paint.shader = SweepGradient(
      startAngle: 0,
      endAngle: 2 * pi,
      colors: lineColors,
      transform: GradientRotation(pi * 1.2),
    ).createShader(
      Rect.fromCircle(center: center, radius: radius),
    );
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start, pi,
        false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
