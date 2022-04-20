import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///代码清单
class DemoViewPaddingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoViewPaddingState();
  }
}

class _DemoViewPaddingState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //状态构建器
      body: SizedBox(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            MediaQueryData queryData = MediaQuery.of(context);
            //底部的遮挡部分
            EdgeInsets padding = queryData.padding;
            //顶部的遮挡部分
            EdgeInsets viewPadding = queryData.viewPadding;
            //键盘的高度
            EdgeInsets viewInsets = queryData.viewInsets;

            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(" padding padding ${padding.bottom}"),
                      Text(" viewPadding padding ${viewPadding.bottom}"),
                      Text(" viewInsets padding ${viewInsets.bottom}"),
                    ],
                  ),
                ),
                Positioned(
                  bottom: padding.bottom+viewInsets.bottom,
                  left: 20,
                  right: 20,
                  child: Container(
                    color: Colors.grey,
                    child: const TextField(
                      decoration: InputDecoration(hintText: "请输入"),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
