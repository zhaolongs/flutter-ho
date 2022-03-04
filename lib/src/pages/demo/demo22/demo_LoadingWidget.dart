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
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoLoadingWidgetPage(),
  ));
}

///代码清单
class DemoLoadingWidgetPage extends StatefulWidget {
  @override
  _DemoLoadingWidgetPageState createState() => _DemoLoadingWidgetPageState();
}

class _DemoLoadingWidgetPageState extends State<DemoLoadingWidgetPage> {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text("加载中"),
      ),
      body: Center(
        child: LoadingWidget(title: "加载中"),
      ),
    );
  }
}

class LoadingWidget extends StatefulWidget {
  final String title;

  const LoadingWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoadingWidgetState();
  }
}

class _LoadingWidgetState extends State<LoadingWidget> {
  int _index = 1;
  String _loadingTitle = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      startTimer();
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      _index++;
      if (_index == 1) {
        _loadingTitle = ".";
      } else if (_index == 2) {
        _loadingTitle = "..";
      } else if (_index == 3) {
        _loadingTitle = "...";
        _index = 0;
      }
      setState(() {});
    });
  }

  void stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(
            width: 12,
          ),
          Text(
            "${widget.title} $_loadingTitle",
          )
        ],
      ),
    );
  }
}
