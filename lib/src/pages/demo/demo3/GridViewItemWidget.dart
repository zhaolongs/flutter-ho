import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GridViewBean.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/2/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///GridView使用的子Item
class GridViewItemWidget extends StatefulWidget {
  final GridBean bean;

  const GridViewItemWidget({Key? key, required this.bean}) : super(key: key);

  @override
  _GridViewItemWidgetState createState() => _GridViewItemWidgetState();
}

class _GridViewItemWidgetState extends State<GridViewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 6,
            bottom: 6,
            left: 10,
            right: 10,
            //点击事件
            child: GestureDetector(
              onTap: () {
                //相反取值
                widget.bean.isSelect = !widget.bean.isSelect;
                setState(() {});
              },
              child: buildContainer(),
            ),
          )
        ],
      ),
    );
  }

  Container buildContainer() {
    Color normalColor = Colors.grey[200]!;

    //如果是选中
    if (widget.bean.isSelect) {
      normalColor = Colors.redAccent;
    }

    return Container(
      //子Widget 居中
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: normalColor,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      child: buildText(),
    );
  }

  buildText() {
    //字体颜色
    Color normalColor = Colors.black;

    //如果是选中
    if (widget.bean.isSelect) {
      normalColor = Colors.white;
    }

    return Text(
      "${widget.bean.title}",
      style: TextStyle(color: normalColor),
    );
  }
}
