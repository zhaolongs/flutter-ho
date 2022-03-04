import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoPhoneWidget(),
  ));
}

///代码清单
class DemoPhoneWidget extends StatefulWidget {
  @override
  _DemoPhoneWidgetState createState() => _DemoPhoneWidgetState();
}

class _DemoPhoneWidgetState extends State<DemoPhoneWidget> {
  late String _dateSelectText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("电话小控件"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            PhoneWidget(
              phone: "12435154235",
              clickAction: (String phone) {
                print("点击事件 $phone");
              },
            ),
          ],
        ),
      ),
    );
  }
}

//定义 电话小控件
class PhoneWidget extends StatefulWidget {
  //点击事件回调
  final Function(String phone) clickAction;

  //显示使用的小电话
  final String phone;

  const PhoneWidget({Key? key, required this.clickAction, required this.phone})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhoneWidgetState();
  }
}

class _PhoneWidgetState extends State<PhoneWidget> {
  //按下标识
  bool _isDown = false;

  @override
  Widget build(BuildContext context) {
    //手势识别
    return GestureDetector(
      //手指按下
      onTapDown: (TapDownDetails details) {
        setState(() {
          _isDown = true;
        });
      },
      //手指抬起
      onTapUp: (TapUpDetails details) {
        setState(() {
          _isDown = false;
        });
      },
      //手指移出事件范围
      onTapCancel: () {
        setState(() {
          _isDown = false;
        });
      },
      //手指抬起
      onTap: () {
        //点击事件
        if (widget.clickAction != null) {
          widget.clickAction(widget.phone);
        }
      },
      child: buildContainer(),
    );
  }

  Container buildContainer() {
    return Container(
      //外部边框
      decoration: BoxDecoration(
          //四个角的圆角
          borderRadius: BorderRadius.all(Radius.circular(4)),
          //边框样式
          border: Border.all(color: Colors.blue, width: 1)),
      child: Row(
        //包裹
        mainAxisSize: MainAxisSize.min,
        children: [
          //前端的小电话
          Container(
            //内边距
            padding: EdgeInsets.all(5),
            child: Icon(
              Icons.phone,
              size: _isDown ? 20 : 18,
              color: Colors.white,
            ),
            //背景
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                )),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "${widget.phone}",
            style: TextStyle(
              fontWeight: _isDown ? FontWeight.w700 : FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
