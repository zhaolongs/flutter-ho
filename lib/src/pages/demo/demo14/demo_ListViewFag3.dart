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
  const DemoListViewFlagPage({Key? key}) : super(key: key);

  @override
  _DemoListViewFlagPageState createState() => _DemoListViewFlagPageState();
}

class _DemoListViewFlagPageState extends State<DemoListViewFlagPage> {
  //多订阅流的方式来创建
  final StreamController<int> _streamController = StreamController.broadcast();

  //滑动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      //层叠布局
      body: Center(
        child: Stack(children: [
          SizedBox(
            height: 44,
            child: buildStreamBuilder(),
          )
        ]),
      ),
    );
  }

  StreamBuilder<dynamic> buildStreamBuilder() {
    return StreamBuilder<int>(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
          buildListView(),
    );
  }

  int _firstIndex = 0;
  int _lastIndex = 0;
  int _currentIndex = 0;

  buildListView() {
    return ListView.custom(
      padding: const EdgeInsets.only(left: 5, right: 5),
      //控制器
      controller: _scrollController,
      //缓存空间
      cacheExtent: 0.0,
      scrollDirection: Axis.horizontal,
      //自定义代理
      childrenDelegate: CustomScrollDelegate(
        (BuildContext context, int index) {
          //ListView的子条目
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [buildItemContainer(index)],
          );
        },
        //条目个数
        itemCount: 1000,
        //滑动回调
        scrollCallBack: (int firstIndex, int lastIndex) {
          print(
              "firstIndex $firstIndex lastIndex $lastIndex _currentIndex $_currentIndex");
          _firstIndex = firstIndex;
          _lastIndex = lastIndex;
        },
      ),
    );
  }

  Container buildItemContainer(int index) {
    return Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        width: 60,
        height: 28,
        child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(
                index == _currentIndex ? 10 : 0,
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (index == _currentIndex) {
                    return Colors.orange;
                  }
                  //默认状态使用灰色
                  return Colors.grey;
                },
              ),
            ),
            onPressed: () {
              _currentIndex = index;
              //计算当前屏幕中间显示的Item的索引
              double mid = (_firstIndex + _lastIndex) / 2;
              //获取当前ListView滑动的距离
              double offset = _scrollController.offset;
              if (index > mid) {
                //向左
                _scrollController.animateTo(offset + 100,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInSine);
                _streamController.add(_currentIndex);
                return;
              }
              //当前显示的是第一个Item
              if (_firstIndex == 0) {
                //完全显示的第一个 不滑动
                if (offset == 0) {
                  return;
                }
                //未完全显示第一个 滑动到顶部
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInSine);
                _streamController.add(_currentIndex);
                return;
              }
              //向右
              _scrollController.animateTo(offset - 100,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInSine);
              _streamController.add(_currentIndex);
            },
            child: Text("$index")));
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}

///ListView 自定义滑动监听回调
class CustomScrollDelegate extends SliverChildBuilderDelegate {
  //定义滑动回调监听
  Function(int firstIndex, int lastIndex)? scrollCallBack;

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
