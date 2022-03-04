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
    home: DemoAnimatedList(),
  ));
}

///代码清单
class DemoAnimatedList extends StatefulWidget {
  @override
  _DemoAnimatedListState createState() => _DemoAnimatedListState();
}

class _DemoAnimatedListState extends State<DemoAnimatedList> {
  List<String> _list = [];

  GlobalKey<AnimatedListState> _globalKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _list.add("早起的年轻人 $i");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedList")),
      body: Column(
        children: [
          Expanded(
            child: buildAnimatedList(),
          ),
          Container(
            height: 80,
            margin: EdgeInsets.only(bottom: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      //插入源数据
                      _list.insert(0, "插入数据 ${DateTime.now()}");
                      //插入动画效果
                      _globalKey.currentState!.insertItem(
                        0, //插入的位置
                        duration: Duration(milliseconds: 400),
                      );
                    },
                    child: Text("插入")),
                SizedBox(
                  width: 22,
                ),
                TextButton(
                    onPressed: () {
                      //移除源数据
                      _list.removeAt(0);
                      //移除动画效果
                      _globalKey.currentState!.removeItem(
                        0,
                        (BuildContext context, Animation<double> animation) {
                          return buildSizeTransition(animation, 0);
                        },
                      );
                    },
                    child: Text("删除")),
              ],
            ),
          )
        ],
      ),
    );
  }

  AnimatedList buildAnimatedList() {
    return AnimatedList(
      //关键key
      key: _globalKey,
      //列表个数
      initialItemCount: _list.length,
      //每个子Item
      itemBuilder:
          (BuildContext context, int index, Animation<double> animation) {
        return buildSizeTransition(animation, index);
      },
    );
  }

  SizeTransition buildSizeTransition(Animation<double> animation, int index) {
    //来个动画
    return SizeTransition(
      //动画构建
      sizeFactor: animation,
      //子UI
      child: SizedBox(
        height: 80.0,
        child: Card(
          color: Colors.primaries[index % Colors.primaries.length],
          child: Center(
            child: Text(
              'Item $index ${_list[index]}',
            ),
          ),
        ),
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 80.0,
          child: Card(
            color: Colors.primaries[index % Colors.primaries.length],
            child: Center(
              child: Text(
                'Item $index ${_list[index]}',
              ),
            ),
          ),
        );
      },
    );
  }
}
