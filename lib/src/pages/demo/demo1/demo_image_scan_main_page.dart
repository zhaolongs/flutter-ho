import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

import 'image_scan_widget.dart';

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
    home: DemoImageScanPage(),
  ));
}

class DemoImageScanPage extends StatefulWidget {
  @override
  _DemoPiePageState createState() => _DemoPiePageState();
}

class _DemoPiePageState extends State<DemoImageScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("图片浏览器"),
        centerTitle: true,
      ),
      //添加一个点击事件
      body: Center(
        child: InkWell(
          child: Image.asset("assets/images/banner1.png"),
          //点击回调
          onTap: () {
            //定义图片数组
            List<String> imageList = [
              "assets/images/banner1.png",
              "assets/images/banner2.png",
              "assets/images/banner1.png",
              "assets/images/banner2.png",
            ];
            //打开一个新的页页 图片滑动浏览
            NavigatorUtils.pushPageByFade(
              context: context,
              targPage: ImageScanWidget(imageList:imageList),
            );
          },
        ),
      ),
    );
  }
}
