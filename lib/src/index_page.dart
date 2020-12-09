import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

import 'pages/common/perlmisson_request_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 启动默认显示的页面
/// 代码清单

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexPageState();
  }
}

class _IndexPageState extends State {
  List<String> _list = [
    "为您更好的体验应用，所以需要获取您的手机文件存储权限，以保存您的一些偏好设置",
    "您已拒绝权限，所以无法保存您的一些偏好设置，将无法使用APP",
    "您已拒绝权限，请在设置中心中同意APP的权限请求",
    "其他错误"
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Navigator.of(context)
          .push(
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return PermissionRequestWidget(
                permission: Permission.camera,
                permissionList: _list,
              );
            }),
      )
          .then((value) {
        if (value == null || !value) {
          //权限请求不通过
        } else {
          //权限请求通过
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/app_icon.png",
          width: 66,
          height: 66,
        ),
      ),
    );
  }
}
