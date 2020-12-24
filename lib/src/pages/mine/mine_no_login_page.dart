import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/login/login_page.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///用户未登录的用户中心
class MineNoLoginPage extends StatefulWidget {
  @override
  _MineNoLoginPageState createState() => _MineNoLoginPageState();
}

class _MineNoLoginPageState extends State<MineNoLoginPage> {
  bool isDown = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0XffCDDEEC),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              //按下
              setState(() {
                isDown = true;
              });
            },
            onTapCancel: () {
              //移出
              setState(() {
                isDown = false;
              });
            },
            onTap: () {
              //跳转登录页面
              setState(() {
                isDown = false;
              });
              NavigatorUtils.pushPageByFade(
                startMills: 1200,
                context: context,
                targPage: LoginPage(),
              );
            },
            child: buildHero(),
          )
        ],
      ),
    );
  }

  Hero buildHero() {
    return Hero(
      tag: "logo",
      child: Material(
        color: Colors.transparent,
        child: buildContainer(),
      ),
    );
  }

  Container buildContainer() {
    return Container(
      alignment: Alignment.center,
      width: 76,
      height: 76,
      decoration: BoxDecoration(
        //四个圆角
        borderRadius: BorderRadius.all(Radius.circular(43)),
        //背景颜色
        color: Colors.redAccent,
        //按下的阴影
        boxShadow: isDown
            ? [
                BoxShadow(
                    offset: Offset(3, 4), color: Colors.black, blurRadius: 13),
              ]
            : null,
      ),
      child: Text(
        "登录",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}
