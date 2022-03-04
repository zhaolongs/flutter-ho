import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/27.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class ListViewDemo2Item extends StatefulWidget {
  final int index;

  ///Ctrl + 回车键自动提示补全
  const ListViewDemo2Item({Key? key, required this.index}) : super(key: key);

  @override
  _ListViewDemo2ItemState createState() => _ListViewDemo2ItemState();
}

class _ListViewDemo2ItemState extends State<ListViewDemo2Item> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      //左右排列
      child: Row(
        children: [
          //左侧的标签
          buildLeftFlagWidget(),
          //右侧的内容
          Expanded(
            child: buildRightWidget(),
          ),
        ],
      ),
    );
  }

  buildLeftFlagWidget() {
    return Container(
      width: 100,
      //高度填充父Widget
      height: double.infinity,
      child: Stack(
        //居中
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              color: Colors.green,
            ),
          ),
          Container(
            width: 30,
            height: 30,
            //子Widget居中
            alignment: Alignment.center,
            //样式
            decoration: BoxDecoration(
                color: Colors.orange,
                //四个角的圆角
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Text(
              "${widget.index}",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18),
            ),
          )
        ],
      ),
    );
  }

  buildRightWidget() {
    return Container(
      padding: EdgeInsets.only(right: 16),
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 66,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          )
        ],
      ),
    );
  }
}
