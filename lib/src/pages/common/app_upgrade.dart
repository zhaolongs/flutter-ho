import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ho/src/bean/bean_version.dart';
import 'package:flutter_ho/src/net/dio_utils.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';
import 'package:flutter_ho/src/utils/toast_utils.dart';
import 'package:install_plugin_custom/install_plugin_custom.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/21.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// gongzhonghao biglead
/// https://study.163.com/instructor/1021406098.htm
/// https://blog.csdn.net/zl18603543572
/// https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/

Future<bool> checkAppVersion(BuildContext context,
    {bool showToast = false}) async {
  Map<String, dynamic> map = {};
  // ResponseInfo partResponseInfo = await DioUtils.instance.getRequest(
  //   url: HttpHelper.appVersion,
  //   queryParameters: map,
  // );
  ResponseInfo responseInfo =
      await Future.delayed(Duration(milliseconds: 1000), () {
    return ResponseInfo(data: {
      "isNeed": true,
      "updateContent": "优化了一些BUG，程序员们正在努力中",
      "packageUrl": "http://pic.studyyoun.com/96b282d9-f82c-46fb-8767-754bd6288775.apk"
    });
  });
  if (responseInfo.success) {
    Map element = responseInfo.data;

    AppVersionBean appVersionBean = AppVersionBean.fromJson(element);
    if (appVersionBean != null) {
      if (appVersionBean.isNeed) {
        showAppUpgradeDialog(
            context: context,
            upgradText: appVersionBean.updateContent,
            apkUrl: appVersionBean.packageUrl);
      } else {
        if (showToast) {
          ToastUtils.showToast("已是最新版本");
        }
      }
    } else {
      if (showToast) {
        ToastUtils.showToast("已是最新版本");
      }
      //
    }
  } else {
    ToastUtils.showToast(responseInfo.message);
  }

  return Future.value(true);
}

/// lib/app/page/common/app_upgrade.dart
///便捷显示升级弹框
void showAppUpgradeDialog({
  @required BuildContext context,
  //是否强制升级
  bool isForce = false,
  //点击背景是否消失
  bool isBackDismiss = false,
  //升级提示内容
  String upgradText = "",
  String apkUrl = "",
}) {
  //通过透明的方式来打开弹框
  NavigatorUtils.pushPageByFade(
      context: context,
      opaque: false,
      targPage: //自定义的弹框页面
          AppUpgradePage(
        isBackDismiss: isBackDismiss,
        isForce: isForce,
        upgradText: upgradText,
        apkUrl: apkUrl,
      ));
}

/// lib/app/page/common/app_upgrade.dart
class AppUpgradePage extends StatefulWidget {
  //是否强制升级
  final bool isForce;

  //点击背景是否消失
  final bool isBackDismiss;

  final String upgradText;

  final String apkUrl;

  AppUpgradePage(
      {this.isForce = false,
      this.upgradText = "",
      this.apkUrl,
      this.isBackDismiss = false});

  @override
  _AppUpgradeState createState() => _AppUpgradeState();
}

class _AppUpgradeState extends State<AppUpgradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 54 透明度的黑色 0~255 0完全透明 255 不透明
      backgroundColor: Colors.black54,
      body: new Material(
        type: MaterialType.transparency,
        //监听Android设备上的返回键盘物理按钮
        child: WillPopScope(
          onWillPop: () async {
            closeApp(context);
            //这里返回true表示不拦截
            //返回false拦截事件的向上传递
            return Future.value(true);
          },
          //填充布局的容器
          child: GestureDetector(
            //点击背景消失
            onTap: () {
              //非强制升级下起作用
              //并且用户设置了点击背景升级弹框消失
              if (!widget.isForce && widget.isBackDismiss) {
                closeApp(context);
              }
            },
            //升级内容区域
            child: buildBodyContainer(context),
          ),
        ),
      ),
    );
  }

  Container buildBodyContainer(BuildContext context) {
    //充满屏幕的透明容器
    return Container(
      width: double.infinity,
      height: double.infinity,
      //线性布局
      child: Column(
        //子Widget水平方向居中
        crossAxisAlignment: CrossAxisAlignment.center,
        //子Widget垂直方向居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildContainer(context),
        ],
      ),
    );
  }

  ///构建白色区域的弹框
  Widget buildContainer(BuildContext context) {
    return ClipRRect(
      //裁剪的圆角背景
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      child: Container(
        width: 280, height: 320,
        color: Colors.white,
        //弹框标题、内容、按钮 线性排列
        child: buildColumn(context),
      ),
    );
  }

  //白色圆角框中线性排列的升级说明
  Column buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      //包裹子Widget
      mainAxisSize: MainAxisSize.min,
      children: [
        //显示标题
        buildHeaderWidget(context),
        SizedBox(
          height: 12,
        ),
        //中间显示的更新内容 可滑动
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 14),
              child: Text(
                "${widget.upgradText}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
        //底部的按钮区域
        buildBottomButton()
      ],
    );
  }

  //底部的按钮区域  构建StreamBuilder
  StreamBuilder<double> buildBottomButton() {
    return StreamBuilder<double>(
      stream: _streamController.stream,
      initialData: 0.0,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        return Container(
          child: Stack(
            children: [
              //自定义按钮
              buildMaterial(context, snapshot),
              //结合 Align 实现的裁剪动画
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: snapshot.data,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  //自定义按钮
  Material buildMaterial(BuildContext context, AsyncSnapshot<double> snapshot) {
    return Material(
      color: Colors.redAccent,
      child: Ink(
        child: InkWell(
          //点击事件
          onTap: onTapFunction,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Text(
              //不同状态显示不同的文本内容
              buildButtonText(snapshot.data),
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  //一个标题 、一个按钮
  Container buildHeaderWidget(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 28,
            child: Text(
              "升级版本",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          //右上角
          Positioned(
            right: 0,
            child: CloseButton(
              onPressed: () {
                closeApp(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void closeApp(BuildContext context) {
    //最好是有一个再次点击时间控制
    //笔者这里省略
    //如果正在下载中 取消网络请求
    if (_cancelToken != null && !_cancelToken.isCancelled) {
      //取消下载
      _cancelToken.cancel();
    }
    //如果是强制升级 点击物理返回键退出应用程序
    if (widget.isForce) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      Navigator.of(context).pop();
    }
  }

  StreamController<double> _streamController = new StreamController();

  //当前状态
  InstallStatues _installStatues = InstallStatues.none;

  //apk保存的路径
  String appLocalPath;

  CancelToken _cancelToken;

  ///使用dio 下载文件
  void downApkFunction() async {
    // 申请写文件权限 一般在应用第一次打开里就申请
    // 这里可以省略
    ///手机储存目录
    String savePath = await getPhoneLocalPath();
    String appName = "rk.apk";

    //创建DIO
    Dio dio = new Dio();
    //取消网络请求标识
    _cancelToken = new CancelToken();

    //Apk下载保存本地路径
    appLocalPath = "$savePath$appName";

    try {
      //参数一 文件的网络储存URL
      //参数二 下载的本地目录文件
      //参数三 取消标识
      //参数四 下载监听
      Response response = await dio.download(widget.apkUrl, appLocalPath,
          cancelToken: _cancelToken, onReceiveProgress: (received, total) {
        if (total != -1) {
          ///当前下载的百分比例
          print((received / total * 100).toStringAsFixed(0) + "%");
          // CircularProgressIndicator(value: currentProgress,) 进度 0-1
          _streamController.add(received / total);
          setState(() {});
        }
      });
      print("下载完成");
      setState(() {
        _streamController.add(0.0);
      });
      _installStatues = InstallStatues.downFinish;
      installApkFunction();
    } catch (e) {
      print('${e.toString()}');
      //取消网络请求
      //下载失败都会在这回调
      //可自行处理
      _installStatues = InstallStatues.downFaile;
      setState(() {});
    }
  }

  ///获取手机的存储目录路径
  ///getExternalStorageDirectory() 获取的是
  ///     android 的外部存储 （External Storage）
  /// getApplicationDocumentsDirectory 获取的是
  ///     ios 的Documents` or `Downloads` 目录
  Future<String> getPhoneLocalPath() async {
    final directory = Theme.of(context).platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  void installApkFunction() async {
    //获取当前App的版本信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    //开始安装
    InstallPluginCustom.installApk(appLocalPath, packageName)
        .then((result) {
      print('install apk $result');
    }).catchError((error) {
      //安装失败
      _installStatues = InstallStatues.installFaile;
      setState(() {});
    });
  }

  String buildButtonText(double progress) {
    String buttonText = "";
    switch (_installStatues) {
      case InstallStatues.none:
        buttonText = '升级';
        break;
      case InstallStatues.downing:
        buttonText = '下载中' + (progress * 100).toStringAsFixed(0) + "%";
        break;
      case InstallStatues.downFinish:
        buttonText = '点击安装';
        break;
      case InstallStatues.downFaile:
        buttonText = '重新下载';
        break;
      case InstallStatues.installFaile:
        buttonText = '重新安装';
        break;
    }
    return buttonText;
  }

  void onTapFunction() {
    //如果是iOS手机就跳转APPStore
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      InstallPluginCustom.gotoAppStore(
          "https://apps.apple.com/cn/app/id1453826566");
      return;
    }
    //第一次下载
    //下载失败点击重试
    if (_installStatues == InstallStatues.none ||
        _installStatues == InstallStatues.downFaile) {
      _installStatues = InstallStatues.downing;
      downApkFunction();
    } else if (_installStatues == InstallStatues.downFinish ||
        _installStatues == InstallStatues.installFaile) {
      //安装失败时
      //下载完成时 点击触发安装
      installApkFunction();
    }
  }
}

enum InstallStatues {
  //无状态
  none,
  //下载中
  downing,
  //下载完成
  downFinish,
  //下载失败
  downFaile,
  //安装失败
  installFaile,
}
