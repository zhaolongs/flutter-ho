import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    home: DemoAnimatedSwitcherLockPage(),
  ));
}

///代码清单
class DemoAnimatedSwitcherLockPage extends StatefulWidget {
  @override
  _DemoAnimatedSwitcherLockPageState createState() =>
      _DemoAnimatedSwitcherLockPageState();
}

class _DemoAnimatedSwitcherLockPageState
    extends State<DemoAnimatedSwitcherLockPage> {
  bool _isLock = false;

  @override
  Widget build(BuildContext context) {

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Error'),
      backgroundColor: Colors.black54,
    ));


    return Scaffold(
      appBar: AppBar(
        title: Text("测试"),
      ),
      body: Center(
        child: DoorLock(
          press: () {
            setState(() {
              _isLock = !_isLock;
            });
          },
          isLock: _isLock,
        ),
      ),
    );
  }
}

class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.press,
    required this.isLock,
  }) : super(key: key);

  final VoidCallback press;
  final bool isLock;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: isLock
            ? SvgPicture.asset(
                "assets/svg/door_lock.svg",
                key: ValueKey("lock"),
              )
            : SvgPicture.asset(
                "assets/svg/door_unlock.svg",
                key: ValueKey("unlock"),
              ),
      ),
    );
  }
}
