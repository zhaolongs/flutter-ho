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
  StreamController<String> _streamController = new StreamController.broadcast();

  //滑动控制器
  ScrollController _scrollController = new ScrollController();

  //创建一个数组保存数据
  List<MonthStatBean> _list = [];

  //上一个数据索引
  int _preIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 1000; i++) {
      //创建模拟数据
      MonthStatBean bean = new MonthStatBean();
      bean.title = "早起的年轻人-$i";
      if (i < 3) {
        bean.subTitle = "早起的年轻人是一个爱运动的程序员";
        bean.time = "2021-02-03 10:34:45";
      } else if (i >= 3 && i < 10) {
        bean.time = "2021-03-04 10:34:45";
        bean.subTitle = "早起的年轻人 也喜欢喝喝茶";
      } else if (i >= 10 && i < 12) {
        bean.time = "2021-04-04 10:34:45";
        bean.subTitle = "早起的年轻人 也时常看看电视剧";
      } else if (i >= 12 && i < 20) {
        bean.time = "2021-05-04 10:34:45";
        bean.subTitle = "早起的年轻人是一个爱运动的程序员";
      } else {
        bean.time = "2021-06-04 10:34:45";
        bean.subTitle = "早起的年轻人是一个爱运动的程序员";
      }

      _list.add(bean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      backgroundColor: Color(0xfff2f2f2),

      //层叠布局
      body: Column(
        children: [
          buildHeaderContainer(context),
          Expanded(
            flex: 1,
            child: buildListView(),
          ),
        ],
      ),
    );
  }

  Container buildHeaderContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      //左对齐
      alignment: Alignment(-1, 0),
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
        child: StreamBuilder<String>(
          //绑定流控制器
          stream: _streamController.stream,
          //初始显示的数据
          initialData: '',
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
          MonthStatBean bean = _list[index];
          //获取下一个数据
          MonthStatBean ? nextBean;
          if (index < _list.length - 1) {
            nextBean = _list[index + 1];
          }

          MonthStatBean ? upBean;
          if (index > 0) {
            upBean = _list[index - 1];
          }

          //ListView的子条目
          return Demo14ListItemWidget(
            index: index,
            bean: bean,
            nextBean: nextBean,
            upBean: upBean,
          );
        },

        //条目个数
        itemCount: _list.length,
        //滑动回调
        scrollCallBack: (int firstIndex, int lastIndex) {
          print("firstIndex $firstIndex lastIndex $lastIndex");

          //取出当前数据

          MonthStatBean bean = _list[firstIndex];

          //取出上一个数据
          MonthStatBean upBean = _list[_preIndex];
          if (firstIndex == 0 ||
              bean.time.substring(0, 11) != upBean.time.substring(0, 11)) {
            _streamController.add(bean.time.substring(0, 11));
          }
          // _streamController.add(bean.time.substring(0,11));
          _preIndex = firstIndex;
        },
      ),
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

  //当前显示的数据
  final MonthStatBean bean;

  //下一个显示的数据
  final MonthStatBean? nextBean;

  //上一个显示的数据
  final MonthStatBean? upBean;

  const Demo14ListItemWidget(
      {Key? key, required this.index, required this.bean, this.nextBean, this.upBean})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Demo14ListItemWidgetState();
  }
}

class _Demo14ListItemWidgetState extends State<Demo14ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    double bottom = 10;
    String ?current;
    if (widget.bean != null) {
      current= widget.bean!.time.substring(0, 11);
      if (widget.nextBean != null) {
        //比较时间
        String nextTime = widget.nextBean!.time.substring(0, 11);
        if (current == nextTime) {
          bottom = 0.0;
        }
      }
    }
    bool isShowHeader = true;
    if (widget.upBean != null) {
      String upTime = widget.upBean!.time.substring(0, 11);
      if (current == upTime) {
        isShowHeader = false;
      }
    }

    return Container(
      margin: EdgeInsets.only(
        bottom: bottom,
      ),
      color: Colors.white,
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          //第一行的标题
          buildHeader(isShowHeader, current),
          SizedBox(
            height: isShowHeader ? 10 : 0,
          ),
          buildRow(),
        ],
      ),
    );
  }

  Widget buildHeader(bool isShowHeader, String ?current) {
    if (!isShowHeader) {
      return Container();
    }
    return Row(
      children: [
        Container(
          height: 18,
          width: 3,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          "$current",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        )
      ],
    );
  }

  Row buildRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                " ${widget.bean!.title}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              //第二行文字
              Text(
                "${widget.bean!.subTitle}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              //第三行文字
              Text(
                "${widget.bean!.time}",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
              )
            ],
          ),
        )
      ],
    );
  }
}

///ListView 自定义滑动监听回调
class CustomScrollDelegate extends SliverChildBuilderDelegate {
  //定义滑动回调监听
  Function(int firstIndex, int lastIndex) scrollCallBack;

  //构造函数
  CustomScrollDelegate(builder,
      {required int itemCount, required this.scrollCallBack})
      : super(builder, childCount: itemCount);

  @override
  double? estimateMaxScrollOffset(int firstIndex, int lastIndex,
      double leadingScrollOffset, double trailingScrollOffset) {
    if (scrollCallBack != null) {
      scrollCallBack(firstIndex, lastIndex);
    }
    return super.estimateMaxScrollOffset(
        firstIndex, lastIndex, leadingScrollOffset, trailingScrollOffset);
  }
}

///定义 ListView的数据模型
class MonthStatBean {
  late String time;
  late String title;
  late String subTitle;
}
