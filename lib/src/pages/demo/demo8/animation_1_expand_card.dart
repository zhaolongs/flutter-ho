import 'package:flutter/material.dart';

main() {
  runApp(
    MaterialApp(
      home: ExpandCardPage(),
    ),
  );
}

class ExpandCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpandCardPageState();
  }
}

class _ExpandCardPageState extends State {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("测试Demo"),
      ),
      body: Center(
        child: buildBody(),
      ),
    );
  }


  //选中标识
  bool _isSelect = false;
  //根据不同的选中标识来获取不同的大小
  double get size => _isSelect ? 120 : 220;

 Widget buildBody() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelect = !_isSelect;
        });
      },
      //卡片
      child: Card(
        //内边距
        child: Padding(
          padding: EdgeInsets.all(20),
          //动画容器
          child: AnimatedContainer(
            //动画时间
            duration: Duration(milliseconds: 1200),
            width: size,
            height: size,
            curve: Curves.ease,
            child: buildAnimateItem(),
          ),
        ),
      ),
    );
  }

  buildAnimateItem() {
    return AnimatedCrossFade(
      //第一个Widget
      firstChild: Image.asset("assets/images/banner1.png"),
      //第二个Widget
      secondChild: Image.asset("assets/images/banner2.png",fit: BoxFit.fill,),
      //显示第几个Widget
      crossFadeState:
          _isSelect ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      //两个Widget切换的时间
      duration: Duration(milliseconds: 1000),
      //定义两个Widget的排版方式
      layoutBuilder: (Widget topChild, Key topChildKey, Widget bottomChild,
          Key bottomChildKey) {
        return Stack(
          children: [
            //第二个 底层
            Positioned.fill(child: bottomChild, key: bottomChildKey),
            //第一个 顶层
            Positioned.fill(child: topChild, key: topChildKey),
          ],
        );
      },
    );
  }
}
