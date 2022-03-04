import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/10/21.
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
    home: PageViewImagePage(),
  ));
}

class PageViewImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageViewImagePageState();
  }
}

class _PageViewImagePageState extends State {
  //控制器
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController(
        //初时显示的页面
        initialPage: 1,
        //每页大小
        viewportFraction: 0.85);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片浏览器"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: AspectRatio(
            aspectRatio: 1,
            child: buildBody(),
          ),
        ),
      ),
    );
  }

  static const List<String> _imageList = [
    "assets/images/p1.webp",
    "assets/images/p2.webp",
    "assets/images/p3.webp",
    "assets/images/p1.webp",
    "assets/images/p2.webp",
    "assets/images/p3.webp",
  ];

  final List<Widget> _imageWidgetList = _imageList
      .map((e) => Image.asset(
            e,
            fit: BoxFit.fill,
          ))
      .toList();

  bool _hasLoading = false;

  buildBody() {
    return PageView.builder(
      onPageChanged: (int index) {
        print("当前选中 $index");
        setState(() {
          _hasLoading = true;
        });
      },
      //子Widget的个数
      itemCount: _imageWidgetList.length,
      controller: _pageController,
      //子Widget布局
      itemBuilder: (BuildContext context, int index) {
        //动画构建器
        return AnimatedBuilder(
          animation: _pageController,
          builder: (BuildContext context, Widget? child) {
            double page = 1.0;
            if (_hasLoading) {
              page = _pageController.page!;
            }
            // -1 0 1
            double result = page - index;

            //result.abs() 绝对值 取正数
            // 1 ~ 0.5
            result = (1 - (result.abs()) * 0.5).clamp(0, 1.0);

            print("page $page  result $result");
            //当前显示页面的大小
            Size size = MediaQuery.of(context).size;

            return Center(
              child: SizedBox(
                width: Curves.easeOut.transform(result) * size.width,
                height: Curves.easeOut.transform(result) * size.height,
                child: _imageWidgetList[index],
              ),
            );
          },
        );
      },
    );
  }
}
