import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:flutter_ho/src/utils/toast_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/11.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

main() {
  runApp(MaterialApp(
    home: ScrollIndexPage(),
  ));
}

class ScrollIndexPage extends StatefulWidget {
  @override
  _ScrollIndexPageState createState() => _ScrollIndexPageState();
}

class _ScrollIndexPageState extends State<ScrollIndexPage> {
  ///第一步 列表显示出来
  ///第二步 列表自动滑动
  ///第三步 中间放大显示
  ///第四步 动态放大与缩小
  ///当前选中的Item
  int _currentSelectIndex = 0;

  //滑动控制器
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    //滑动过程中也实时刷新
    _scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Demo"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            //子Widget剧中
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("当前选中的Itme $_currentSelectIndex"),
              Container(height: 180, child: buildSingleChildScrollView()),
              Icon(Icons.arrow_upward_outlined),
            ],
          )),
    );
  }

  Widget buildSingleChildScrollView() {
    //监听滑动结束
    return NotificationListener<ScrollEndNotification>(
      //通知兼听
      onNotification: (ScrollNotification scrollNotification) {
        //滑动信息封装
        ScrollMetrics metrics = scrollNotification.metrics;
        //获取当前的滑动位置
        double pixels = metrics.pixels;
        //最大可滑动距离
        double maxScrollExtent = metrics.maxScrollExtent;
        //计算滑动位置
        double scrollIndex = pixels / _itemWidth;
        double scrollOffset = pixels % _itemWidth;
        //当前选中
        _currentSelectIndex = scrollIndex.round();

        if (pixels == maxScrollExtent) {
          ToastUtils.showToast('已滑动到底部');
        } else if (pixels == 0) {
          ToastUtils.showToast('已滑动到顶部');
        } else {
          if (scrollOffset != 0.0) {
            LogUtils.e("滑动结束 未滑动到边界 scrollIndex $scrollIndex");
            Future.delayed(Duration.zero, () {
              _scrollController.animateTo(
                _currentSelectIndex * _itemWidth,
                duration: Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            });
          } else {
            LogUtils.e("滑动结束 滑动到边界 scrollIndex $scrollIndex");
          }
        }
        setState(() {});
        return true;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        //滑动方向 为水平 方向
        scrollDirection: Axis.horizontal,
        child: Row(
          children: buildChildren(),
        ),
      ),
    );
  }

  buildChildren() {
    List<Widget> list = [];
    for (int i = 0; i < 20; i++) {
      list.add(buildItemWidget(i));
    }
    return list;
  }

  double _itemWidth = 0.0;

  Widget buildItemWidget(int index) {
    //一页显示5个
    _itemWidth = MediaQuery.of(context).size.width / 5;

    Color textColor = Colors.grey;
    double fontSize = 14;
    double imageWidth = 55.0;

    //当控制器绑定成功后再使用
    if (_scrollController.hasClients) {
      //获取当前滑动的距离
      double offset = _scrollController.offset;
      double scorllIndex = offset / _itemWidth;
      //1.9 -2.0
      double uniWidth = scorllIndex - scorllIndex.round();

      LogUtils.e("uniWidth $uniWidth");
      if ((scorllIndex.round() + 2) == index) {
        textColor = Colors.redAccent;
        fontSize = 16;
        imageWidth = 55.0 + 20 * (1.0 - uniWidth);
      } else if ((scorllIndex.round() + 3) == index) {
        imageWidth = 55.0 + 20 * uniWidth;
      }
    }

    return Container(
      width: _itemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //裁剪圆形
          ClipOval(
            child: Image.asset(
              "assets/images/app_icon.png",
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.fill,
            ),
          ),
          //图片
          //文字
          Text(
            "测试$index",
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
