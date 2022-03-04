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
///
///
///
///
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoHeroPage(),
  ));
}

///代码清单
class DemoHeroPage extends StatefulWidget {
  @override
  _DemoHeroPageState createState() => _DemoHeroPageState();
}

class _DemoHeroPageState extends State<DemoHeroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hero")),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return buildItemWidget(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
        itemCount: 200,
      ),
    );
  }

  Widget buildItemWidget(int index) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("早起的年轻人 $index"),
          SizedBox(
            height: 22,
          ),
          InkWell(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (BuildContext contex) {
              //   return DemoDetailsPage(
              //     tag: "tag$index",
              //   );
              // }));

              Navigator.of(context).push(
                PageRouteBuilder(
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      //目标页面
                      return DemoDetailsPage(tag: "tag$index");
                    },
                    //打开页面时的时间
                    transitionDuration: Duration(milliseconds: 1400),
                    //关闭页面的时间
                    reverseTransitionDuration: Duration(milliseconds: 1000),
                    //过渡动画构建一下
                    transitionsBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child) {
                      //透明渐变动画
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        child: child,
                      );
                    }),
              );
            },
            child: HeroMode(
              //默认是 true 有 Hero 过渡动画
              // 为 false 时 禁用动画
              enabled: false,
              child: Hero(
                tag: "tag$index",
                child: Material(
                  child: Image.asset(
                    "assets/images/banner1.png",
                    height: 100,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DemoDetailsPage extends StatefulWidget {
  final String tag;

  const DemoDetailsPage({Key? key, required this.tag}) : super(key: key);

  @override
  _DemoDetailsPageState createState() => _DemoDetailsPageState();
}

class _DemoDetailsPageState extends State<DemoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
      ),
      body: Center(
        child: Container(
          child: Hero(
            tag: widget.tag,
            child: Material(
              child: Image.asset(
                "assets/images/banner1.png",
                height: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
