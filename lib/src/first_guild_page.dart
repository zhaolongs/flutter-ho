import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';
import 'package:flutter_ho/src/utils/sp_utils.dart';

import 'home_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/22.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class FirstGuildPage extends StatefulWidget {
  @override
  _FirstGuildPageState createState() => _FirstGuildPageState();
}

class _FirstGuildPageState extends State<FirstGuildPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //第一层的图片
          buildBackground(width, height),
          //第二层的点指示
          buildIndfot(),
          //第三层的去首页
          buildGoHome(),
        ],
      ),
    );
  }

  Positioned buildGoHome() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          AnimatedContainer(
            duration: Duration(milliseconds: 800),
            height: _currentIndex == 3 ? 44 : 0,
            width: _currentIndex == 3 ? 180 : 0,
            child: ElevatedButton(
              child: Text("去首页"),
              onPressed: () {
                LogUtils.e("点击了去首页面");
                SPUtil.save("flutter_ho_isFirst",true);
                NavigatorUtils.pushPageByFade(
                  context: context,
                  targPage: HomePage(),
                  isReplace: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildIndfot() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 60,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buidlIndefot(_currentIndex == 0),
          buidlIndefot(_currentIndex == 1),
          buidlIndefot(_currentIndex == 2),
          buidlIndefot(_currentIndex == 3),
        ],
      ),
    );
  }

  Widget buidlIndefot(bool isSelect) {
    return AnimatedContainer(
      height: 12,
      width: isSelect ? 40 : 12,
      margin: EdgeInsets.only(left: 16),
      duration: Duration(milliseconds: 800),
      decoration: BoxDecoration(
        color: Colors.deepOrangeAccent,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  Positioned buildBackground(double width, double height) {
    return Positioned.fill(
      child: PageView(
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        children: [
          Image.asset(
            "assets/images/sp01.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/images/sp02.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/images/sp03.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
          Image.asset(
            "assets/images/sp05.png",
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
