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
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TestPage(),
  ));
}

///代码清单
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("滑动条Slider"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          child: Theme(
            data: ThemeData(
              sliderTheme: SliderThemeData(
                  trackHeight: 2.0,
                  //滑块的大小配置
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 12.0, disabledThumbRadius: 3.0),
                  //滑块颜色
                  thumbColor: Colors.blue,
                  //滑块边缘的颜色
                  overlayColor: Colors.blue.withOpacity(0.3),
                  //滑块边缘的大小
                  overlayShape:RoundSliderOverlayShape(overlayRadius: 20.0),
                  //滑块左侧刻度颜色
                  activeTickMarkColor: Colors.orange,
                  //滑块左侧的滑动条颜色
                  activeTrackColor: Colors.redAccent,
                  //滑块右侧的滑动条颜色
                  inactiveTrackColor: Colors.grey,
                  //滑块右侧的刻度颜色
                  inactiveTickMarkColor: Colors.blueGrey,
                  //气泡文本样式
                  valueIndicatorTextStyle: TextStyle(color: Colors.white),
                  showValueIndicator:ShowValueIndicator.always,
                  //气泡背景
                  valueIndicatorColor: Colors.black),
            ),
            child: Slider(
              //当前滑动条的值
              value: _sliderValue,
              //滑动回调方法
              onChanged: (data) {
                print('change:$data');
                setState(() {
                  this._sliderValue = data;
                });
              },
              //开始滑动
              onChangeStart: (data) {
                print('start:$data');
              },
              //滑动结束
              onChangeEnd: (data) {
                print('end:$data');
              },
              //最小值
              min: 0.0,
              //最大值
              max: 10.0,
              //将滑动条几等分
              divisions: 10,
              //拖动滑块时可在滑块上方显示的文字
              label: '$_sliderValue',

            ),
          ),
        ),
      ),
    );
  }
}
