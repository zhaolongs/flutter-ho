//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// /// 创建人： Created by zhaolong
// /// 创建时间：Created by  on 3/26/21.
// ///
// /// 可关注公众号：我的大前端生涯   获取最新技术分享
// /// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
// /// 可关注博客：https://blog.csdn.net/zl18603543572
// ///
// main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: DemoConnectivityPage(),
//   ));
// }
//
// ///代码清单
// class DemoConnectivityPage extends StatefulWidget {
//   @override
//   _DemoConnectivityPageState createState() => _DemoConnectivityPageState();
// }
//
// class BottomNavigationWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _DemoConnectivityPageState();
// }
//
// class _DemoConnectivityPageState extends State<DemoConnectivityPage> {
//   @override
//   void initState() {
//     super.initState();
//     //获取网络连接
//     isConnectedType();
//     //设置个监听
//     connectLiserner();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("网络连接"),
//       ),
//       body: Center(
//         child: Text("当前网络连接为 $_netType"),
//       ),
//     );
//   }
//
// //判断是否联网
//   Future<bool> isConnected() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   //获取网络类型
//   late String _netType;
//
//   void isConnectedType() async {
//     //获取网络连接类型
//     ConnectivityResult connectivityResult =
//         await (Connectivity().checkConnectivity());
//
//     if (connectivityResult == ConnectivityResult.mobile) {
//       // 网络类型为移动网络
//       _netType = "4G";
//     } else if (connectivityResult == ConnectivityResult.wifi) {
//       // 网络类型为WIFI
//       _netType = "WIFI";
//     } else {
//       _netType = "未联接";
//     }
//     setState(() {});
//   }
//
//   //添加网络切换监听
//   void connectLiserner() async {
//     //获取Stream
//     Stream<ConnectivityResult> resultStream =
//         Connectivity().onConnectivityChanged;
//     //添加监听
//     resultStream.listen((ConnectivityResult result) {
//       //
//       print("有变化 ${result}");
//     });
//   }
// }
