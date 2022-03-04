import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/10/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DragImageAnimationPage(),
  ));
}

class DragImageAnimationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragImageAnimationPageState();
  }
}

class _DragImageAnimationPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("图片"),
      ),
      body: DragWidget(
        child: Image.asset(
          "assets/images/banner1.png",
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}

class DragWidget extends StatefulWidget {
  final Widget child;

  const DragWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DragWidgetState();
  }
}

class _DragWidgetState extends State<DragWidget>
    with SingleTickerProviderStateMixin {
  //
  Alignment _dragAlignment = Alignment(0, 0);

  //动画控制器
  late AnimationController _animationController;

  late Animation<Alignment> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController.unbounded(vsync: this);

    //添加一个动画兼听
    _animationController.addListener(() {
      _dragAlignment = _animation.value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      //开始滑动
      onPanStart: (DragStartDetails details) {
        _animationController.stop(canceled: true);
      },
      //滑动更新
      onPanUpdate: (DragUpdateDetails details) {
        _dragAlignment += Alignment(
          details.delta.dx / size.width * 2,
          details.delta.dy / size.height * 2,
        );
        setState(() {});
      },
      //滑动结束
      onPanEnd: (DragEndDetails details) {
        //参数一 滑动结束里的速度
        startAnimation(details.velocity.pixelsPerSecond, size);
      },
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }

  void startAnimation(Offset pixelsPerSecond, Size size) {
    //drve 方法 将控制器与 Tween 动画关联
    _animation = _animationController.drive(
      //一个范围的动画
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment(0.0, 0.0),
      ),
    );

    //SpringSimulation 弹簧
    SpringSimulation springSimulation = SpringSimulation(
      //弹簧的属性配置
      SpringDescription(
        mass: 10, //质量
        stiffness: 1000, //硬度
        damping: 0.75, //阻尼系数
      ),
      0,
      1,
      -Offset(
        pixelsPerSecond.dx / size.width,
        pixelsPerSecond.dy / size.height,
      ).distance,
    );

    _animationController.animateWith(springSimulation);
  }
}
