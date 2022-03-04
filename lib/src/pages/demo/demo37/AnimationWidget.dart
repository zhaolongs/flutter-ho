import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 5/27/21.
///

/// [child] ListView 子Item显示的布局
/// [index] ListView 子Itme位置
///  AnimationWidget buildAnimationWidget(Widget child,int index) {
//     return AnimationWidget(
//       duration: 400 + index % 3 * 100,
//       child: child,
//     );
//   }

///代码清单
///向上平移微动画  可应用于 ListView
class AnimationWidget extends StatefulWidget {
  final Widget child;
  final int duration;

  const AnimationWidget({
    Key? key,
    required this.child,
    this.duration = 200,
  }) : super(key: key);

  @override
  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  //动画控制器
  late AnimationController _controller;

  //AnimationController是一个特殊的Animation对象，在屏幕刷新的每一帧，就会生成一个新的值，
  // 默认情况下，AnimationController在给定的时间段内会线性的生成从0.0到1.0的数字
  //用来控制动画的开始与结束以及设置动画的监听
  //vsync参数，存在vsync时会防止屏幕外动画（动画的UI不在当前屏幕时）消耗不必要的资源
  //duration 动画的时长，这里设置的 seconds: 2 为2秒，当然也可以设置毫秒 milliseconds：2000.
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    //begin: Offset.zero, end: Offset(1, 0) 以左下角为参考点，相对于左下角坐标 x轴方向向右 平移执行动画的view 的1倍 宽度，y轴方向不动，也就是水平向右平移
    //begin: Offset.zero, end: Offset(1, 1) 以左下角为参考点，相对于左下角坐标 x轴方向向右 平移执行动画的view 的1倍 宽度，y轴方向 向下 平衡执行动画view 的1倍的高度，也就是向右下角平移了
    _animation = Tween(
      begin: Offset(0, 0.2),
      end: Offset(0, 0),
    ).animate(_controller);
    Future.delayed(Duration.zero, () {
      //开始执行动画
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
