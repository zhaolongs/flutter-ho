import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoListViewFlagPage(),
  ));
}

///代码清单
class DemoListViewFlagPage extends StatefulWidget {
  @override
  _DemoListViewFlagPageState createState() => _DemoListViewFlagPageState();
}

class _DemoListViewFlagPageState extends State<DemoListViewFlagPage> {
  //多订阅流的方式来创建
  StreamController<int> _streamController = new StreamController.broadcast();

  //滑动控制器
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      backgroundColor: Color(0xfff2f2f2),

      //层叠布局
      body: CustomScrollView(
        semanticChildCount: 5,
        slivers: <Widget>[
          SliverGrid(

            //排列规则配置
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //主方向排列个数 这里指个数
              crossAxisCount: 2,
              //子Widget的宽高比例
              childAspectRatio: 2.0,
              //次方向子 Widget 排列的间隔
              crossAxisSpacing: 12,
              //主方向 子 Widget 排列的间隔
              mainAxisSpacing: 10,
              //最大宽度
              mainAxisExtent: 200,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Image.asset("assets/images/banner1.png");
              },
              //子Widget 每次创建时都会回调这个
              semanticIndexCallback: (Widget widget, int localIndex) {
                print("localIndex $localIndex");
                return localIndex;
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }

  CustomScrollView buildCustomScrollView() {
    return CustomScrollView(
      semanticChildCount: 4,
      slivers: <Widget>[
        SliverGrid(
          //排列规则配置
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //主方向排列个数 这里指个数
            crossAxisCount: 2,
            //子Widget的宽高比例
            childAspectRatio: 1.0,
            //次方向子 Widget 排列的间隔
            crossAxisSpacing: 12,
            //主方向 子 Widget 排列的间隔
            mainAxisSpacing: 10,
            //最大缓存长度
            mainAxisExtent: 120,
          ),
          //子Widget的排列过程代理
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Image.asset("assets/images/banner1.png");
            },
            //总个数
            childCount: 8,
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Image.asset("assets/images/banner1.png");
            },
            childCount: 2,
            semanticIndexOffset: 2,
          ),
        ),
      ],
    );
  }
}
