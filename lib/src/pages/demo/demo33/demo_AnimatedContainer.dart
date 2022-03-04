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
    home: DemoAnimatedContainer(),
  ));
}

///代码清单
class DemoAnimatedContainer extends StatefulWidget {
  @override
  _DemoAnimatedContainerState createState() => _DemoAnimatedContainerState();
}

class _DemoAnimatedContainerState extends State<DemoAnimatedContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("AnimatedContainer")),
      body: Center(
        child: AnimatedContainer(
          //动画速率
          curve: Curves.easeInBack,
          //动画执行结束的回调
          onEnd: () {},
          //子Widget 对齐方式
          alignment: Alignment.center,
          width: 300,
          //高度
          height: 200,
          //背景颜色
          // color: Colors.deepPurple,
          //内边距
          padding: EdgeInsets.all(0),
          //复杂装饰样式
          decoration: BoxDecoration(
            //背景色
            color: Colors.red,
            //边框圆角
            borderRadius: BorderRadius.all(Radius.circular(20)),
            //边框
            border: Border.all(color: Colors.deepPurple, width: 1),
            //线性渐变
            gradient: LinearGradient(
                //开始位置
                begin: Alignment(0, 0),
                //结束位置
                end: Alignment(1, 0),
                //颜色组
                colors: [
                  Colors.blue,
                  Colors.deepOrange,
                  Colors.orange,
                ]),
          ),

          duration: Duration(seconds: 2),
          child: Text(
            "早起的年轻人",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
