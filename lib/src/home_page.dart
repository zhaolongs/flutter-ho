import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/home/home_item3_page.dart';
import 'package:flutter_ho/src/pages/home/home_item_page.dart';

import 'pages/mine/mine_main_page.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/14.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///首页面
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //当前选中的标识
  int _currentIndex = 0;

  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: PageView(
          controller: _pageController,
          //不可左右滑动
          physics: NeverScrollableScrollPhysics(),
          children: [
            //第一个视频列表播放页面
            HomeItemPage(1),
            //第二个视频列表播放页面
            HomeItemPage(2),
            //第三个文章列表页面
            HomeItem3Page(),
            //第四个个人中心页面
            MineMainPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        //当前选中的Item 默认为 0
        currentIndex: _currentIndex,
        //点击回调
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
            _pageController.jumpToPage(value);
          });
        },
        //显示文字
        type: BottomNavigationBarType.fixed,
        //选中的颜色
        selectedItemColor: Colors.redAccent,
        //未选中颜色
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.five_g), label: "发现"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
      ),
    );
  }
}
