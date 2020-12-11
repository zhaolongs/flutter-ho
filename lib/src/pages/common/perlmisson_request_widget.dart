import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///权限请求模版
class PermissionRequestWidget extends StatefulWidget {
  final Permission permission;
  final List<String> permissionList;
  final bool isCloseApp;
  final String leftButtonText;

  PermissionRequestWidget(
      {@required this.permission,
      @required this.permissionList,
      this.leftButtonText = "再考虑一下",
      this.isCloseApp = false});

  @override
  _PermissionRequestWidgetState createState() =>
      _PermissionRequestWidgetState();
}

class _PermissionRequestWidgetState extends State<PermissionRequestWidget>
    with WidgetsBindingObserver {
  //页面的初始化函数
  @override
  void initState() {
    super.initState();
    checkPermisson();
    //注册观察者
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isGoSetting) {
      checkPermisson();
    }
  }

  void checkPermisson({PermissionStatus status}) async {
    //权限
    Permission permission = widget.permission;

    if (status == null) {
      //权限状态
      status = await permission.status;
    }

    if (status.isUndetermined) {
      //第一次申请
      showPermissonAlert(widget.permissionList[0], "同意", permission);
    } else if (status.isDenied) {
      if (Platform.isIOS) {
        showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
            isSetting: true);
        return;
      }
      //用户第一次申请拒绝
      showPermissonAlert(widget.permissionList[1], "重试", permission);
    } else if (status.isPermanentlyDenied) {
      //第二次申请 用户拒绝
      showPermissonAlert(widget.permissionList[2], "去设置中心", permission,
          isSetting: true);
    } else {
      //通过
      Navigator.of(context).pop(true);
    }
  }

  //是否去设置中心
  bool _isGoSetting = false;

  void showPermissonAlert(
      String message, String rightString, Permission permission,
      {bool isSetting = false}) {
    showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              padding: EdgeInsets.all(12),
              child: Text(message),
            ),
            actions: [
              //左边的按钮
              CupertinoDialogAction(
                child: Text("${widget.leftButtonText}"),
                onPressed: () {
                  if (widget.isCloseApp) {
                    closeApp();
                  } else {
                    Navigator.of(context).pop(false);
                  }
                },
              ),
              //右边的按钮
              CupertinoDialogAction(
                child: Text("$rightString"),
                onPressed: () {
                  //关闭弹框
                  Navigator.of(context).pop();
                  if (isSetting) {
                    _isGoSetting = true;
                    //去设置中心
                    openAppSettings();
                  } else {
                    //申请权限
                    requestPermiss(permission);
                  }
                },
              )
            ],
          );
        },
        context: context);
  }

  void requestPermiss(Permission permission) async {
    //发起权限申请
    PermissionStatus status = await permission.request();
    //校验
    checkPermisson();
  }

  /// TODO 暂未使用
  void requestPermissionList(List<Permission> list) async {
    //多个权限申请
    Map<Permission, PermissionStatus> statuses = await [
    Permission.location,
        Permission.storage,
    ].request();
  }

  void closeApp() {
    //关闭应用的方法
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  @override
  void dispose() {
    //注销观察者
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
    );
  }
}
