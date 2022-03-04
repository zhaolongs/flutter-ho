import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/11.
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
    home: DemoLoginPage(),
  ));
}

class DemoLoginPage extends StatefulWidget {
  @override
  _DemoPiePageState createState() => _DemoPiePageState();
}

class _DemoPiePageState extends State<DemoLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //来设置一下状态栏
      body: AnnotatedRegion(
        //状态栏样式设置
        value: SystemUiOverlayStyle(
          //iOS状态栏文字白色
          statusBarBrightness: Brightness.dark,
        ),
        child: Container(
          child: buildBody(),
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }

  buildBody() {
    //层叠布局
    return Stack(
      //子Widget居中
      alignment: Alignment.center,
      children: [
        //底层的背景 填充
        Positioned.fill(
          child: Image.asset(
            "assets/images/login_bg.webp",
            //图片填充
            fit: BoxFit.fill,
          ),
        ),
        //模糊层
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),

        //表层的内容
        Positioned(
          bottom: 160,
          left: 60,
          right: 60,
          child: buildColumn(),
        ),
        Positioned(
          top: 160,
          child: Text(
            "去发现",
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            //背景边框圆角
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //边框
              border: Border.all(color: Colors.white)),
          child: Text(
            "注册",
            style: TextStyle(
              //文字颜色
              color: Colors.white,
              //文字大小
              fontSize: 18,
              //文字加粗
              fontWeight: FontWeight.w500,
            ),
          ),
          height: 54,
          alignment: Alignment.center,
        ),
        SizedBox(
          height: 30,
        ),
        //中间的线
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                height: 1.0,
                color: Colors.white,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4, right: 4),
              child: Text(
                "或者跳过",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 20),
                height: 1.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        //登录
        Container(
          decoration: BoxDecoration(
            //背景边框圆角
              borderRadius: BorderRadius.all(Radius.circular(30)),
              //边框
              border: Border.all(color: Colors.white)),
          child: Text(
            "登录",
            style: TextStyle(
              //文字颜色
              color: Colors.white,
              //文字大小
              fontSize: 18,
              //文字加粗
              fontWeight: FontWeight.w500,
            ),
          ),
          height: 54,
          alignment: Alignment.center,
        )
      ],
    );
  }
}
