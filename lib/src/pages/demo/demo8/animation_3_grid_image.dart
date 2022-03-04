import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

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
    home: GridViewImagePage(),
  ));
}

class GridViewImagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GridViewImagePageState();
  }
}

class _GridViewImagePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("图片浏览器"),
      ),
      body: buildBody(),
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

  Widget buildBody() {
    return GridView.builder(
      itemCount: 200,
      //子Widget排列代理
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //每列子Widget 个数
        crossAxisCount: 5,
        //列之间的距离
        crossAxisSpacing: 12,
      ),
      itemBuilder: (BuildContext context, int index) {
        //取出每个子图片
        String path = _imageList[index % _imageList.length];
        return GridViewItemWidget(path);
      },
    );
  }
}

class GridViewItemWidget extends StatelessWidget {
  final String path;

  GridViewItemWidget(this.path);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          NavigatorUtils.pushPageByCenterScale(
            context: context,
            targPage: ScendPage(
              path: path,
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.asset(path),
        ),
      ),
    );
  }
}

class ScendPage extends StatelessWidget {
  final String path;

  const ScendPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(path),
          ),
        ),
      ),
    );
  }
}
