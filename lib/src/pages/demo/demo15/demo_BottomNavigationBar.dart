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
    home: DemoBottomNavigationPage(),
  ));
}

///代码清单
class DemoBottomNavigationPage extends StatefulWidget {
  @override
  _DemoBottomNavigationPageState createState() =>
      _DemoBottomNavigationPageState();
}

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DemoBottomNavigationPageState();
}

class _DemoBottomNavigationPageState extends State<DemoBottomNavigationPage> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;

  List<Widget> widgetList = [
    DemoBottomNavigationItem(
      index: 0,
    ),
    DemoBottomNavigationItem(
      index: 1,
    ),
    DemoBottomNavigationItem(
      index: 2,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[_currentIndex],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            _currentIndex = 1;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              label: "首页"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              ),
              label: "传输"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.airplay,
                color: _bottomNavigationColor,
              ),
              label: "我的"),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class DemoBottomNavigationItem extends StatelessWidget {
  final int index;

  const DemoBottomNavigationItem({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$index"),
    );
  }
}
