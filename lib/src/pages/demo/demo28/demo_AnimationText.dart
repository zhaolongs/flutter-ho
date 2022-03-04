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
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoAnimationTextPage(),
  ));
}

///代码清单
class DemoAnimationTextPage extends StatefulWidget {
  @override
  _DemoAnimationTextPageState createState() => _DemoAnimationTextPageState();
}

class _DemoAnimationTextPageState extends State<DemoAnimationTextPage> {
  bool _isSign = false;

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildAnimationText() {
    return AnimatedTextKit(
      animatedTexts: [
        FadeAnimatedText(
          "早起的年轻人",
          duration: Duration(milliseconds: 2000),
        ),
      ],
      //重复的次数
      totalRepeatCount: 1,
      //重复执行时 中间间隔的时间
      pause: Duration(milliseconds: 200),
      //为 true 时，点击动画提前结束 默认是 false
      displayFullTextOnTap: true,
      //点击事件
      onTap: () {
        print("onTap");
      },
      onFinished: () {
        print("动画执行完毕的回调");
      },
    );
  }

  Widget buildAnimationText1() {
    return AnimatedTextKit(
      animatedTexts: [
        //打字效果
        TypewriterAnimatedText("早起的年轻人",
            //每出一个字的时间
            speed: Duration(milliseconds: 100),
            //字体样式
            textStyle: TextStyle(
              color: Colors.blue,
              fontSize: 22,
            ),
            //文字对齐方式
            textAlign: TextAlign.start,
            //结尾显示文本
            cursor: "_",
            //动画曲线
            curve: Curves.ease),
      ],
      //重复的次数
      totalRepeatCount: 1,
      //重复执行时 中间间隔的时间
      pause: Duration(milliseconds: 200),
      //为 true 时，点击动画提前结束 默认是 false
      displayFullTextOnTap: true,
      //点击事件
      onTap: () {
        print("onTap");
      },
      onFinished: () {
        print("动画执行完毕的回调");
      },
    );
  }

  Widget buildAnimationText2() {
    return AnimatedTextKit(
      animatedTexts: [
        RotateAnimatedText("早起的年轻人",
            duration: Duration(milliseconds: 1000),
            rotateOut: true,
            transitionHeight: 60,
            alignment: Alignment.centerLeft,
            textAlign: TextAlign.start),
        RotateAnimatedText("早起的年轻人2",
            duration: Duration(milliseconds: 1000),
            rotateOut: true,
            transitionHeight: 60,
            alignment: Alignment.centerLeft,
            textAlign: TextAlign.start),
        RotateAnimatedText("早起的年轻人3",
            duration: Duration(milliseconds: 1000),
            rotateOut: true,
            transitionHeight: 60,
            alignment: Alignment.centerLeft,
            textAlign: TextAlign.start),
      ],
      //重复的次数
      totalRepeatCount: 1,
      //重复执行时 中间间隔的时间
      pause: Duration(milliseconds: 200),
      //为 true 时，点击动画提前结束 默认是 false
      displayFullTextOnTap: true,
      //点击事件
      onTap: () {
        print("onTap");
      },
      onFinished: () {
        print("动画执行完毕的回调");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.white,
              width: double.infinity,
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              child: buildAnimationText(),
            ),
            ElevatedButton(onPressed: () {}, child: Text("测试")),
          ],
        ),
      ),
    );
  }
}
