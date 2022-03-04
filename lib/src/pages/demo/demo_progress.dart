import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/11.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///
main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DemoProgerssPage(),
  ));
}

class DemoProgerssPage extends StatefulWidget {
  @override
  _DemoPiePageState createState() => _DemoPiePageState();
}

class _DemoPiePageState extends State<DemoProgerssPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    //动画控制器创建
    _animationController = new AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 1400,
        ));
    //添加一个监听
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("进度指示"),
      ),
      body: Container(
        //填充
        width: double.infinity,
        height: double.infinity,
        //内边距
        padding: EdgeInsets.all(30),
        child: buildColumn(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("开始"),
        onPressed: () {
          if (_animationController.isCompleted) {
            //如果动画执行完毕了 就反向执行
            _animationController.reverse();
          } else {
            //重置动画
            _animationController.reset();
            //正向执行
            _animationController.forward();
          }
        },
      ),
    );
  }

  Column buildColumn() {
    return Column(
      //子Widget 居中
      mainAxisAlignment: MainAxisAlignment.center,
      children: [buildRow()],
    );
  }

  Row buildRow() {
    return Row(
      children: [
        Expanded(
          //圆角矩形
          child: ClipRRect(
            //圆角大小
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Container(
              height: 16,
              //层叠到一起的进度
              child: buildStack(),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text("100条")
      ],
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        //背景
        Positioned.fill(
          child: Container(
            height: 16,
            color: Colors.grey,
          ),
        ),
        //进度
        ClipRect(
          //对齐
          child: Align(
            //裁剪比例
            widthFactor: _animationController.value,
            child: Container(
              height: 16,
              //背景装饰
              decoration: BoxDecoration(
                //线性渐变
                gradient: LinearGradient(colors: [
                  Color(0xff20cca8),
                  Color(0xff116edd),
                ]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
