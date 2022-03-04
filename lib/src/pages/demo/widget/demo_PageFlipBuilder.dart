import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/27/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    Key? key,
    required this.frontBuilder,
    required this.backBuilder,
    this.nonInteractiveAnimationDuration = const Duration(milliseconds: 500),
    this.interactiveFlipEnabled = true,
    this.flipAxis = Axis.horizontal,
    this.maxTilt = 0.003,
    this.maxScale = 0.2,
  }) : super(key: key);
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final Duration nonInteractiveAnimationDuration;
  final bool interactiveFlipEnabled;
  final Axis flipAxis;
  final double maxTilt;
  final double maxScale;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  late AnimationController _controller;

  /// Starts a page flip.
  ///
  /// Example:
  /// ```dart
  /// PageFlipBuilder(
  ///   key: pageFlipKey,
  ///   frontBuilder: (_) => Screen1(
  ///     onFlip: () => pageFlipKey.currentState?.flip(),
  ///   ),
  ///   backBuilder: (_) => Screen2(
  ///     onFlip: () => pageFlipKey.currentState?.flip(),
  ///   ),
  /// );
  /// ```
  void flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details, double crossAxisLength) {
    print(crossAxisLength);
    _controller.value += details.primaryDelta! / crossAxisLength;
  }

  void _handleDragEnd(DragEndDetails details, double crossAxisLength) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.dismissed) return;

    const velocityThreshold = 2.0;
    final velocity = widget.flipAxis == Axis.horizontal
        ? details.velocity.pixelsPerSecond.dx
        : details.velocity.pixelsPerSecond.dy;
    final flingVelocity = velocity / crossAxisLength;

    // if value and velocity are 0, the gesture was a tap so we return early
    if (_controller.value == 0.0 && flingVelocity == 0.0) {
      return;
    }

    if (_controller.value > 0.5 ||
        _controller.value > 0.0 && flingVelocity > velocityThreshold) {
      _controller.fling(velocity: velocityThreshold);
    } else if (_controller.value < -0.5 ||
        _controller.value < 0.0 && flingVelocity < -velocityThreshold) {
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > 0.0 ||
        _controller.value > 0.5 && flingVelocity < -velocityThreshold) {
      // controller can't fling to 0.0 because the lowerBound is -1.0
      // so we decrement the value by 1.0 and toggle the state to get the same effect
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > -0.5 ||
        _controller.value < -0.5 && flingVelocity > velocityThreshold) {
      // controller can't fling to 0.0 because the upperBound is 1.0
      // so we increment the value by 1.0 and toggle the state to get the same effect
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: velocityThreshold);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.nonInteractiveAnimationDuration,
      // lowerBound of -1.0 is needed for the back flip
      lowerBound: -1.0,
      // upperBound of 1.0 is needed for the front flip
      upperBound: 1.0,
    );
    _controller.value = 0.0;
    _controller.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    _controller.dispose();
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      // The controller always completes a forward animation with value 1.0
      // and a reverse animation with a value of -1.0.
      // By resetting the value to 0.0 and toggling the state
      // we are preparing the controller for the next animation
      // while preserving the widget appearance on screen.
      _controller.value = 0.0;
      setState(() => _showFrontSide = !_showFrontSide);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.flipAxis == Axis.horizontal;
    return LayoutBuilder(builder: (_, constraints) {
      final crossAxisLength =
          isHorizontal ? constraints.maxWidth : constraints.maxHeight;
      return GestureDetector(
        onHorizontalDragUpdate: widget.interactiveFlipEnabled && isHorizontal
            ? (details) => _handleDragUpdate(details, crossAxisLength)
            : null,
        onHorizontalDragEnd: widget.interactiveFlipEnabled && isHorizontal
            ? (details) => _handleDragEnd(details, crossAxisLength)
            : null,
        onVerticalDragUpdate: widget.interactiveFlipEnabled && !isHorizontal
            ? (details) => _handleDragUpdate(details, crossAxisLength)
            : null,
        onVerticalDragEnd: widget.interactiveFlipEnabled && !isHorizontal
            ? (details) => _handleDragEnd(details, crossAxisLength)
            : null,
        child: AnimatedPageFlipBuilder(
            animation: _controller,
            frontBuilder: widget.frontBuilder,
            backBuilder: widget.backBuilder,
            showFrontSide: _showFrontSide,
            flipAxis: widget.flipAxis,
            maxTilt: widget.maxTilt,
            maxScale: widget.maxScale),
      );
    });
  }
}

class AnimatedPageFlipBuilder extends AnimatedWidget {
  const AnimatedPageFlipBuilder({
    Key? key,
    required Animation<double> animation,
    required this.showFrontSide,
    required this.frontBuilder,
    required this.backBuilder,
    this.flipAxis = Axis.horizontal,
    this.maxTilt = 0.003,
    this.maxScale = 0.2,
  }) : super(key: key, listenable: animation);
  final bool showFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final Axis flipAxis;
  final double maxTilt;
  final double maxScale;

  Animation<double> get animation => listenable as Animation<double>;

  bool get _isAnimationFirstHalf => animation.value.abs() < 0.5;

  double _getTilt() {
    var tilt = (animation.value - 0.5).abs() - 0.5;
    if (animation.value < -0.5) {
      tilt = 1.0 + animation.value;
    }
    return tilt * (_isAnimationFirstHalf ? -maxTilt : maxTilt);
  }

  double _rotationAngle() {
    final rotationValue = animation.value * pi;
    if (animation.value > 0.5) {
      return pi - rotationValue; // input from 0.5 to 1.0
    } else if (animation.value > -0.5) {
      return rotationValue; // input from -0.5 to 0.5
    } else {
      return -pi - rotationValue; // input from -1.0 to -0.5
    }
  }

  double _scale() {
    final absValue = animation.value.abs();
    return 1.0 - (absValue < 0.5 ? absValue : 1.0 - absValue) * maxScale;
  }

  @override
  Widget build(BuildContext context) {
    final child = _isAnimationFirstHalf ^ showFrontSide
        ? backBuilder(context)
        : frontBuilder(context);
    final matrix = flipAxis == Axis.horizontal
        ? (Matrix4.rotationY(_rotationAngle())..setEntry(3, 0, _getTilt()))
        : (Matrix4.rotationX(_rotationAngle())..setEntry(3, 1, _getTilt()));
    final scale = _scale();
    return Transform(
      transform: matrix * Matrix4.diagonal3Values(scale, scale, 1.0),
      child: child,
      alignment: Alignment.center,
    );
  }
}
