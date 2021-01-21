import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    home: DemoVideoListPage(),
  ));
}

class DemoVideoListPage extends StatefulWidget {
  @override
  _DemoPiePageState createState() => _DemoPiePageState();
}

class _DemoPiePageState extends State<DemoVideoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("ListView Demo"),
        centerTitle: true,
      ),
      //列表懒加载
      body: ListView.builder(
        //子item 个数
        itemCount: 300,
        //子item 布局
        itemBuilder: (BuildContext context, int index) {
          //封装成单独的Widget
          return ListItemWidget(index: index);
        },
      ),
    );
  }
}

class ListItemWidget extends StatefulWidget {
  final int index;

  const ListItemWidget({Key key, this.index}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListItemWidgetState();
  }
}

class _ListItemWidgetState extends State<ListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      //左右排列
      child: Row(
        children: [
          //等比例布局
          Expanded(
            child: buildItemCell(),
          ),
          SizedBox(width: 6,),
          Expanded(
            child: buildItemCell(),
          ),
        ],
      ),
    );
  }

  buildItemCell() {
    //获取当前的Wiget 尺寸
    double screenWidth = MediaQuery.of(context).size.width;
    //计算图片的宽度
    double imageWidth = screenWidth / 2;
    //计算图片的高度
    double imageHeight = imageWidth * 1080 / 1920;
    //竖直方向线性排列
    return Column(
      //子Widget 左对齐
      crossAxisAlignment: CrossAxisAlignment.start,
      //包裹子Widget
      mainAxisSize: MainAxisSize.min,
      children: [
        //一张图片
        Image.asset(
          "assets/images/banner1.png",
          width: imageWidth,
          height: imageHeight,
          //填充
          fit: BoxFit.fill,
        ),
        //标题
        Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            "早起年轻人 浪迹江湖",
            //单行显示
            maxLines: 1,
            //超出省略号
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              //字体粗体
              fontWeight: FontWeight.w500,
              //颜色
              color: Color(0xff333333),
              //字体大小
              fontSize: 16,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Text(
            "一个程序员 喝点茶 哈哈",
            //单行显示
            maxLines: 1,
            //超出省略号
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              //字体粗体
              fontWeight: FontWeight.w400,
              //颜色
              color: Color(0xff666666),
              //字体大小
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
