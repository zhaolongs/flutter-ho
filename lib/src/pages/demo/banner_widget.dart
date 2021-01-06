import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/6.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class BannerWidget extends StatefulWidget {
  final List<String> imageList;

  BannerWidget({@required this.imageList});

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _total = 5;
  int _current = 1;
  Timer _timer;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    //轮播图个数
    _total = widget.imageList.length;
    //轮播控制器
    _pageController = new PageController(initialPage: 5000);
    //定时器
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      //滑动到下一页
      _pageController.nextPage(
        curve: Curves.linear,
        duration: Duration(
          milliseconds: 200,
        ),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //轮播 图
    return Container(
      color: Colors.red,
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          //第一层 轮播
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 10000,
              onPageChanged: (value) {
                setState(() {
                  _current = value % widget.imageList.length;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                String image =
                    widget.imageList[index % widget.imageList.length];
                return Image.asset(
                  image,
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          //第二层 指示器
          Positioned(
            right: 14,
            bottom: 14,
            child: buildContainer(),
          ),
        ],
      ),
    );
  }

  Container buildContainer() {
    return Container(
      alignment: Alignment.center,
      width: 50,
      height: 24,
      decoration: BoxDecoration(
          color: Colors.grey[200].withOpacity(0.5),
          //设置圆角
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(
        "$_current/$_total",
        textAlign: TextAlign.center,
      ),
    );
  }
}
