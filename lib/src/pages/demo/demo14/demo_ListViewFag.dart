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
      body: Stack(
        //子Widget 居中
        alignment: Alignment.center,
        children: [
          //第一层的列表
          Positioned.fill(
            child: buildListView(),
          ),
          //第二层的显示标签
          Positioned(
            child: buildButtonFlag(),
            right: 10,
          ),
        ],
      ),
    );
  }

  buildListView() {
    return ListView.custom(
      //控制器
      controller: _scrollController,
      //缓存空间
      cacheExtent: 0.0,
      //自定义代理
      childrenDelegate: CustomScrollDelegate(
        (BuildContext context, int index) {
          //ListView的子条目
          return Demo14ListItemWidget(
            index: index,
          );
        },

        //条目个数
        itemCount: 1000,
        //滑动回调
        scrollCallBack: (int firstIndex, int lastIndex) {
          print("firstIndex $firstIndex lastIndex $lastIndex");
          _streamController.add(firstIndex);
        },
      ),
    );
  }

  buildButtonFlag() {
    return Column(
      children: [
        //椭圆裁剪
        ClipOval(
          child: Container(
            //背景
            color: Colors.blueGrey,
            //文字标签 按钮
            child: TextButton(
              onPressed: () {
                print("点击");
                _scrollController.animateTo(
                  0,
                  curve: Curves.ease,
                  duration: Duration(milliseconds: 400),
                );
              },
              child: StreamBuilder<int>(
                //绑定流控制器
                stream: _streamController.stream,
                //初始显示的数据
                initialData: 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

class Demo14ListItemWidget extends StatefulWidget {
  final int index;

  const Demo14ListItemWidget({Key? key, required this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Demo14ListItemWidgetState();
  }
}

class _Demo14ListItemWidgetState extends State<Demo14ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      color: Colors.white,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          //左侧的图片
          Image.asset(
            "assets/images/banner3.png",
            width: 100,
          ),
          SizedBox(
            width: 10,
          ),
          //右侧的文字
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //第一行文字
                Text(
                  "早起的年轻人 ${widget.index}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                //第二行文字
                Text(
                  "早起的年轻人 是一个爱运动的程序跋山涉水",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

///ListView 自定义滑动监听回调
class CustomScrollDelegate extends SliverChildBuilderDelegate {
  //定义滑动回调监听
  Function(int firstIndex, int lastIndex) ? scrollCallBack;

  //构造函数
  CustomScrollDelegate(builder, {required int itemCount, this.scrollCallBack})
      : super(builder, childCount: itemCount);

  @override
  double? estimateMaxScrollOffset(int firstIndex, int lastIndex,
      double leadingScrollOffset, double trailingScrollOffset) {
    if (scrollCallBack != null) {
      scrollCallBack!(firstIndex, lastIndex);
    }
    return super.estimateMaxScrollOffset(
        firstIndex, lastIndex, leadingScrollOffset, trailingScrollOffset);
  }
}
