import 'dart:ui';

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
    home: DemoPhysicalModel(),
  ));
}

///代码清单
class DemoPhysicalModel extends StatefulWidget {
  @override
  _DemoPhysicalModelState createState() => _DemoPhysicalModelState();
}

class _DemoPhysicalModelState extends State<DemoPhysicalModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ImageFilter"),
      ),
      backgroundColor: Colors.white,
      //来显示一张图片
      body: Container(
        //填充
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        //来个层叠布局
        child: Stack(
          alignment: Alignment.center,
          children: [
            //第一层 来一个背景
            Positioned.fill(
              child: Image.asset(
                "assets/images/sp01.png",
                //图片填充一下
                fit: BoxFit.fill,
              ),
            ),
            //第二层居中显示一个昵称
            // BackdropFilter 对底层的所有的Widget者起作用
            //当我们只想作用于中间这小块时
            //可以裁剪一下
            ClipRect(
              child: BackdropFilter(
                //高斯模糊度设置
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 0),
                child: buildChildBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildChildBox() {
    return Container(
      width: 240,
      height: 180,
      //color 与 decoration 是互斥的
      //color: Colors.white,
      //来个圆角
      decoration: BoxDecoration(
        //颜色来个透明度
        color: Colors.white.withOpacity(0.2),
        //四个圆角
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      //居中一下
      alignment: Alignment.center,
      child: Text(
        "早起的年轻人",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildImageFiltered() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          "早起的年轻人",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 0),
          child: Container(
            color: Colors.white.withAlpha(0),
          ),
        ),
      ],
    );
  }

  ImageFiltered buildImageFiltered2() {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 6, sigmaY: 0),
      child: Text(
        "早起的年轻人",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildWidget() {
    return Container(
      width: 100,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Image.asset(
          "assets/images/sp02.png",
          fit: BoxFit.fitWidth,
          width: 100,
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 0),
      child: Container(
        color: Colors.white,
        child: Text(
          "早起的年轻人",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Item2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //标签部分
          Container(
            child: TabBar(
              tabs: [],
            ),
          ),
          Expanded(
            //基础部分
            child: Container(),
          ),
        ],
      ),
    );
  }
}
