import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

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

class _IndexPageState extends State with WidgetsBindingObserver {
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

  @override
  void dispose() {
    //注销观察者
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
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

  void checkPermisson({PermissionStatus status}) async {
    //权限
    Permission permission = Permission.storage;

    if (status == null) {
      //权限状态
      status = await permission.status;
    }

    if (status.isUndetermined) {
      //第一次申请
      showPermissonAlert(_list[0], "同意", permission);
    } else if (status.isDenied) {
      //用户第一次申请拒绝
      showPermissonAlert(_list[1], "重试", permission);
    } else if (status.isPermanentlyDenied) {
      //第二次申请 用户拒绝
      showPermissonAlert(_list[2], "去设置中心", permission, isSetting: true);
    } else {
      //通过
    }
  }

  List<String> _list = [
    "为您更好的体验应用，所以需要获取您的手机文件存储权限，以保存您的一些偏好设置",
    "您已拒绝权限，所以无法保存您的一些偏好设置，将无法使用APP",
    "您已拒绝权限，请在设置中心中同意APP的权限请求",
    "其他错误"
  ];

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
                child: Text("退出应用"),
                onPressed: () {
                  closeApp();
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

  void closeApp() {
    //关闭应用的方法
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }
}
