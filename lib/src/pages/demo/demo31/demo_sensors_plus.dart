import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

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
    home: DemoSensorsPlusPage(),
  ));
}

///代码清单
class DemoSensorsPlusPage extends StatefulWidget {
  @override
  _DemoSensorsPlusPageState createState() => _DemoSensorsPlusPageState();
}

class _DemoSensorsPlusPageState extends State<DemoSensorsPlusPage> {
  bool _isShow = false;

  @override
  void initState() {
    super.initState();

    //加速度 受重力影响
    accelerometerEvents.listen((AccelerometerEvent event) async {
      //[AccelerometerEvent (x: 0.0992431640625, y: 0.11407470703125, z: 9.776962280273438)]
      // print(event);
      int value = 10;
      if (event.x.abs() > value ||
          event.y.abs() > value ||
          event.z.abs() > value) {
        if (!_isShow) {
          _isShow = true;
          dynamic result = await showDialog<bool>(
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text("摇一摇"),
                  content: Image.asset(
                    "assets/images/banner1.png",
                    width: 200,
                  ),
                );
              },
              context: context,
              barrierDismissible: true);
          _isShow = false;
        }
      }
    });

    //加速度 不受重力影响
    userAccelerometerEvents.listen((UserAccelerometerEvent event) {});

    //陀螺仪传感器
    gyroscopeEvents.listen((GyroscopeEvent event) {
      //[GyroscopeEvent (x: 0.00042724609375, y: 0.0005340576171875, z: -0.0003204345703125)]
      // print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    ///使用 Scaffold 组件来构建应用的基本页面
    /// 页面的架构
    return Scaffold(
      appBar: AppBar(title: Text("sensors_plus")),
      body: Center(
        child: Text("摇一摇"),
      ),
    );
  }
}
