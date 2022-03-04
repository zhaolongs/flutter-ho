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
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoWillPopScope(),
  ));
}

///代码清单
class DemoWillPopScope extends StatefulWidget {
  @override
  _DemoWillPopScopeState createState() => _DemoWillPopScopeState();
}

class _DemoWillPopScopeState extends State<DemoWillPopScope> {
  //上一次点击事件
  int pretime = 0;

  @override
  Widget build(BuildContext context) {
    //返回 或者说退出页面里的提示
    return WillPopScope(
      onWillPop: () async {
        print("返回");
        //当前时间
        int now = DateTime.now().millisecond;
        //计算时间差
        int flag = now - pretime;
        //两次点击时间太长不做处理
        if (flag > 1000) {
          print("返回1");
          pretime = now;
          return false;
        }
        print("返回2");
        showTips();
        //拦截
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("拦截返回按钮"),
        ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  void showTips() async {
    bool? flag = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("提示"),
            content: Text("您确定要退出吗???"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text("确定")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("取消"))
            ],
          );
        });
  }
}
