import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    home: DemoInputTipsWidgetPage(),
  ));
}

///代码清单
class DemoInputTipsWidgetPage extends StatefulWidget {
  @override
  _DemoInputTipsWidgetPageState createState() =>
      _DemoInputTipsWidgetPageState();
}

class _DemoInputTipsWidgetPageState extends State<DemoInputTipsWidgetPage> {
  bool _isSign = false;

  List<String> _tipeList = [
    "123trggfgs",
    "1fgdsh23",
    "12hgfh3",
    "12tyh3",
    "1hghfhgfh23",
    "1288883",
  ];
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Text"),
      ),
      body: InputTipsWidget(
        tipeList: _tipeList,
        textEditingController: _textEditingController,
        clickAction: (String value) {
          _textEditingController.text = value;
          setState(() {});
        },
        inputDecoration: InputDecoration(hintText: "请输入内容"),
      ),
    );
  }
}

class InputTipsWidget extends StatefulWidget {
  final List<String>? tipeList;

  final TextEditingController? textEditingController;

  //输入框的文本样式
  final TextStyle? inputTextStyle;

  //高亮提示
  final TextStyle? hightTextStyle;
  final InputDecoration? inputDecoration;
  final Function(String value)? clickAction;

  InputTipsWidget(
      {this.tipeList,
      this.textEditingController,
      this.inputTextStyle,
      this.hightTextStyle,
      this.inputDecoration,
      this.clickAction});

  @override
  State<StatefulWidget> createState() {
    return InputTipsWidgetState();
  }
}

class InputTipsWidgetState extends State<InputTipsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            child: TextField(
              style: widget.hightTextStyle,
              decoration: widget.inputDecoration,
              controller: widget.textEditingController,
              onChanged: (String inputValue) {
                print("输入内容 $inputValue");
                _streamController.add(inputValue);
              },
            ),
          ),
          StreamBuilder(
              stream: _streamController.stream,
              initialData: "",
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.data!.length == 0 || widget.tipeList == null) {
                  return Container();
                }

                List<String> themList = [];
                for (int i = 0; i < widget.tipeList!.length; i++) {
                  String pre = widget.tipeList![i];
                  if (pre.contains(snapshot.data!)) {
                    themList.add(pre);
                  }
                }
                if (themList.length == 0) {
                  return Container();
                }
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                  ),
                  color: Colors.white,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.all(12),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: themList.length,
                      itemBuilder: (BuildContext context, int index) {
                        String tips = themList[index];
                        String currentStr = snapshot.data!;
                        return GestureDetector(
                          child: buildItemWidget(tips, currentStr),
                          onTap: () {
                            if (widget.clickAction != null) {
                              widget.clickAction!(tips);
                              _streamController.add("");
                            }
                          },
                        );
                      }),
                );
              }),
        ],
      ),
    );
  }

  StreamController<String> _streamController = StreamController();

  Widget buildItemWidget(String tips, String currentStr) {
    if (tips == currentStr || currentStr.length > tips.length) {
      return Text(
        tips,
        style: TextStyle(color: Colors.red),
      );
    } else if (tips.contains(currentStr)) {
      return RichText(
        textAlign: TextAlign.start, // 设置富文本对齐方式
        text: TextSpan(style: widget.hightTextStyle, children: [
          TextSpan(
              text: "${tips.substring(0, currentStr.length)}",
              style: TextStyle(color: Colors.red)),
          TextSpan(
              text: "${tips.substring(currentStr.length, tips.length - 1)}",
              style: TextStyle(color: Colors.grey)),
        ]),
      );
    } else {
      return Text(tips);
    }
  }
}
