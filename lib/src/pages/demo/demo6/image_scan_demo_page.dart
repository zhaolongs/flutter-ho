import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/25.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageScanPage(),
    ),
  );
}

class ImageScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ImageScanPageState();
  }
}

class _ImageScanPageState extends State<ImageScanPage> {
  List<String> _imageList = [
    "assets/images/sp01.png",
    "assets/images/sp02.png",
    "assets/images/sp03.png",
    "assets/images/sp05.png",
    "assets/images/sp01.png",
    "assets/images/sp02.png",
    "assets/images/sp03.png",
    "assets/images/sp05.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片浏览"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        //内边距
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //第一部分图片
            buildShowBigImage(),
            //第二部分所有的图
            buildScrollImge(),
          ],
        ),
      ),
    );
  }

  buildShowBigImage() {
    return Expanded(
      flex: 3,
      child: PageTransitionSwitcher(
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation) {
          return SharedAxisTransition(
              child: child,
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.scaled);
        },
        duration: Duration(milliseconds: 400),
        child: Container(
          key: UniqueKey(),
          color: Colors.blueGrey,
          child: Image.asset(_imageList[_currentIndex]),
        ),
      ),
    );
  }

  //当前选中的
  int _currentIndex = 0;

  //滑动控制器
  ScrollController _scrollController = new ScrollController();

  buildScrollImge() {
    return Expanded(
      flex: 1,
      child: Container(
        //列表
        child: ListView.builder(
          controller: _scrollController,
          //图片数量
          itemCount: _imageList.length,
          //横向滑动
          scrollDirection: Axis.horizontal,
          //子Item
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              alignment: Alignment.center,
              children: [
                //点击事件
                GestureDetector(
                  onTap: () {
                    int preIndex = _currentIndex;
                    if (index > 1) {
                      if (index > preIndex) {
                        //向左滑动
                        _scrollController.animateTo(140.0 * (index),
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 200));
                      } else if (index == preIndex) {
                        //不滑动
                      } else {
                        //向右滑动
                        _scrollController.animateTo(140.0 * (index - 1),
                            curve: Curves.linear,
                            duration: Duration(milliseconds: 200));
                      }
                    }
                    _currentIndex = index;
                    setState(() {});
                  },
                  child: buildContainer(index),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Container buildContainer(int index) {
    //容器
    return Container(
      //外边距
      margin: EdgeInsets.only(left: 8, right: 8),
      //背景
      decoration: BoxDecoration(
        //边框圆角
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        //边框
        border: Border.all(
            width: 4,
            color: _currentIndex == index ? Colors.redAccent : Colors.white),
      ),
      //裁剪图片
      child: ClipRRect(
        //裁剪圆角
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        //显示的图片
        child: Image.asset(
          _imageList[index],
          fit: BoxFit.fitWidth,
          height: 100,
          width: 140,
        ),
      ),
    );
  }
}
