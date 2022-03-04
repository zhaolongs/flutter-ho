import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'SelectPhotoWidget.dart';

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
    home: DemoSelectImageWidgetPage(),
  ));
}

///代码清单
class DemoSelectImageWidgetPage extends StatefulWidget {
  @override
  _DemoSelectImageWidgetPageState createState() =>
      _DemoSelectImageWidgetPageState();
}

class _DemoSelectImageWidgetPageState extends State<DemoSelectImageWidgetPage> {
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text("图片选择组件")),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          //图片选择组件
          child: SelectPhotoWidget(
            header: Text(
              "请选择照片",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            //标题下的红色提醒文本
            tips: "请注意 最多选择5张图片",
            //图片选择回调
            imageSelectAction: (List<String> list) {
              print("实时选择回调${list.toString()}");
            },
            //最大选择图片数据
            maxSelect: 6,
            //预设图片
            imageList: [],
          ),
        ),
      ),
    );
  }
}
