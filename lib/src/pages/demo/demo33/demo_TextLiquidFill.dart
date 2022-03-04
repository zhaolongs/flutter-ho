import 'package:animated_text_kit/animated_text_kit.dart';
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
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoTextLiquidFill(),
  ));
}

///代码清单
class DemoTextLiquidFill extends StatefulWidget {
  @override
  _DemoTextLiquidFillState createState() => _DemoTextLiquidFillState();
}

class _DemoTextLiquidFillState extends State<DemoTextLiquidFill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TextLiquidFill")),
      body: Center(child: _typer()),
    );
  }

  Widget _textLiquidFillAnimation() {
    return SizedBox(
      child: Center(
        child: TextLiquidFill(
          text: 'Flutter Devs',
          waveDuration: Duration(seconds: 5),
          waveColor: Colors.blue,
          boxBackgroundColor: Colors.green,
          textStyle: TextStyle(
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _wavy() {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.red,
        fontSize: 25.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText("Flutter is Google's UI toolkit,",
              speed: Duration(milliseconds: 100)),
          WavyAnimatedText('for building beautiful Apps',
              speed: Duration(milliseconds: 100)),
        ],
        isRepeatingAnimation: true,
        repeatForever: true,
      ),
    );
  }

  //闪烁动画文本
  Widget _flicker() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 30,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText('FlutterDevs specializes in creating,',
                speed: Duration(milliseconds: 1000), entryEnd: 0.7),
            FlickerAnimatedText('cost-effective and',
                speed: Duration(milliseconds: 1000), entryEnd: 0.7),
            FlickerAnimatedText("efficient applications!",
                speed: Duration(milliseconds: 1000), entryEnd: 0.7),
          ],
        ),
      ),
    );
  }

  //着色动画文本：
  Widget _colorize() {
    return SizedBox(
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Mobile Developer',
              textStyle: const TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
              colors: [Colors.black, Colors.blue],
            ),
            ColorizeAnimatedText(
              'Software Testing',
              textStyle: const TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
              colors: [Colors.black, Colors.blue],
            ),
            ColorizeAnimatedText(
              'Software Engineer',
              textStyle: const TextStyle(
                color: Colors.red,
                fontSize: 30,
              ),
              colors: [Colors.black, Colors.blue],
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
        ),
      ),
    );
  }

  //打字机动画文本
  Widget _typeWriter() {
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                    'FlutterDevs specializes in creating cost-effective',
                    curve: Curves.easeIn,
                    speed: Duration(milliseconds: 80)),
                TypewriterAnimatedText(
                    'and efficient applications with our perfectly crafted,',
                    curve: Curves.easeIn,
                    speed: Duration(milliseconds: 80)),
                TypewriterAnimatedText(
                    'creative and leading-edge flutter app development solutions',
                    curve: Curves.easeIn,
                    speed: Duration(milliseconds: 80)),
                TypewriterAnimatedText('for customers all around the globe.',
                    curve: Curves.easeIn, speed: Duration(milliseconds: 80)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //旋转动画文本
  Widget _rotate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 10.0, height: 100.0),
        const Text(
          'Flutter',
          style: TextStyle(fontSize: 40.0),
        ),
        const SizedBox(width: 15.0, height: 100.0),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 35.0,
            color: Colors.red,
          ),
          child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                RotateAnimatedText('AWESOME'),
                RotateAnimatedText('Text'),
                RotateAnimatedText('Animation'),
              ]),
        ),
      ],
    );
  }

  //打字动画文本
  Widget _typer() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'popin',
          color: Colors.red,
        ),
        child: AnimatedTextKit(isRepeatingAnimation: true, animatedTexts: [
          TyperAnimatedText('When you talk, you are only repeating',
              speed: Duration(milliseconds: 100)),
          TyperAnimatedText('something you know.But if you listen,',
              speed: Duration(milliseconds: 100)),
          TyperAnimatedText(' you may learn something new.',
              speed: Duration(milliseconds: 100)),
          TyperAnimatedText('– Dalai Lama', speed: Duration(milliseconds: 100)),
        ]),
      ),
    );
  }

  Widget _fade() {
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
        child: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FadeAnimatedText('THE HARDER!!',
                  duration: Duration(seconds: 3),
                  fadeOutBegin: 0.9,
                  fadeInEnd: 0.7),
              FadeAnimatedText('YOU WORK!!',
                  duration: Duration(seconds: 3),
                  fadeOutBegin: 0.9,
                  fadeInEnd: 0.7),
              FadeAnimatedText('THE LUCKIER!!!',
                  duration: Duration(seconds: 3),
                  fadeOutBegin: 0.9,
                  fadeInEnd: 0.7),
              FadeAnimatedText('YOU GET!!!!',
                  duration: Duration(seconds: 3),
                  fadeOutBegin: 0.9,
                  fadeInEnd: 0.7),
            ],
          ),
        ),
      ),
    );
  }

  //缩放动画文本
  Widget _scale() {
    return SizedBox(
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 50.0,
          fontFamily: 'SF',
        ),
        child: Center(
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ScaleAnimatedText('Eat', scalingFactor: 0.2),
              ScaleAnimatedText('Code', scalingFactor: 0.2),
              ScaleAnimatedText('Sleep', scalingFactor: 0.2),
              ScaleAnimatedText('Repeat', scalingFactor: 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
