import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/25.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppRootPage(),
    ),
  );
}

class AppRootPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _AppRootPageState();
  }
}

class _AppRootPageState extends State<AppRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滑动条"),
      ),
      //居中
      body: Center(
        child: Container(
          width: 240,
          height: 120,
          child: buildThem(),
        ),
      ),
    );
  }

  //Slider的值
  double _sliderValue = 1.0;

  Widget buildThem() {
    return Theme(
      data: ThemeData(
        sliderTheme: SliderThemeData(
          trackHeight: 1,
          //滑块的颜色
          thumbColor: Colors.deepOrange,
          //滑块的大小
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
          //点击滑块边缘的颜色
          overlayColor: Colors.deepPurpleAccent.withOpacity(0.2),
          //点击滑块边缘的显示半径
          overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
          //滑动左侧滚动条的颜色
          activeTrackColor: Colors.blue,
          //滚动条右侧的颜色
          inactiveTrackColor: Colors.grey,
          //任何情况都显示气泡
          showValueIndicator: ShowValueIndicator.always,
          //气泡的文字样式
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
          //气泡的背景
          valueIndicatorColor: Colors.redAccent
        )
      ),
      child: buildSliderWidget(),
    );
  }

  Widget buildSliderWidget() {
    return Slider(
      //Slider的当前的值  0.0 ~ 1.0
      value: _sliderValue,
      min: 1.0,
      max: 100.0,
      //平均分成的等分
      divisions: 100,
      //滚动时会回调
      onChanged: (double value) {
        _sliderValue = value;
        print("Value $_sliderValue");
        setState(() {});
      },
      onChangeStart: (double startValue) {
        print("开始滚动");
      },
      onChangeEnd: (double endValue) {
        print("停止 滚动");
      },
      //滑块以及滑动左侧的滚动条颜色
      // activeColor: Colors.redAccent,
      //滑块右侧的滚动条颜色
      // inactiveColor: Colors.blue,
      //气泡
      label: "${_sliderValue.toStringAsFixed(1)}",
    );
  }
}
