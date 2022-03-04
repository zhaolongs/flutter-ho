import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/2/13.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

///代码清单
class FlowItemWidget extends StatefulWidget {
  @override
  _FlowItemWidgetState createState() => _FlowItemWidgetState();
}

class _FlowItemWidgetState extends State<FlowItemWidget> {
  @override
  Widget build(BuildContext context) {
    return buildItemWidget();
  }

  buildItemWidget() {
    return Container(
      //圆角矩形裁剪
      child: ClipRRect(
        //分别裁剪四个角的圆角
        borderRadius: BorderRadius.only(
          //左上角圆角
          topLeft: Radius.circular(40),
          //左下角圆角
          bottomLeft: Radius.circular(40),
          //右上角圆角
          topRight: Radius.circular(4),
          //右下角圆角
          bottomRight: Radius.circular(4),
        ),
        child: Container(
          height: 70,
          color: Colors.white,
          child: buildRow(),
        ),
      ),
    );
  }

  buildRow() {
    return Row(
      children: [
        //头像
        buildLeftImage(),
        SizedBox(
          width: 10,
        ),
        //信息
        Expanded(
          child: buildMiddleInfo(),
        ),
        //关注
        buildRightFlow(),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  ///右侧的关注按钮
  ClipRRect buildRightFlow() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(40)),
      child: GestureDetector(
        onTap: () {
          print("点击了关注");
        },
        child: Container(
          padding: EdgeInsets.only(left: 14, right: 14, top: 4, bottom: 4),
          child: Text(
            "关注",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurpleAccent.withOpacity(0.5),
                  Colors.blueGrey
                ]),
          ),
        ),
      ),
    );
  }

  ///中间的个人信息
  Column buildMiddleInfo() {
    return Column(
      //设置包裹子Wiget
      mainAxisSize: MainAxisSize.min,
      //次方向左对齐  水平方向
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "早起的年轻人",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 4,
        ),
        Text("一个奋斗的程序员"),
      ],
    );
  }

  ///左侧头像
  Container buildLeftImage() {
    return Container(
      padding: EdgeInsets.all(6),
      //圆形裁剪
      child: ClipOval(
        child: Image.asset("assets/images/app_icon.png"),
      ),
    );
  }
}
