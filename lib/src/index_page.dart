import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ho/src/pages/common/protocol_model.dart';
import 'package:flutter_ho/src/pages/common/user_helper.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';
import 'package:flutter_ho/src/utils/sp_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'first_guild_page.dart';
import 'pages/common/perlmisson_request_widget.dart';
import 'welcome_page.dart';

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

class _IndexPageState extends State with ProtocolModel {
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
      initData();
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

  void initData() async {
    //当前应用的运行环境
    //当App运行在release环境时
    bool isLog = !bool.fromEnvironment("dart.vm.product");

    LogUtils.init(islog: isLog);

    LogUtils.e("权限申请");
    //权限申请
    NavigatorUtils.pushPageByFade(
        context: context,
        //目标页面
        targPage: PermissionRequestWidget(
          //所需要申请的权限
          permission: Permission.camera,
          //显示关闭应用按钮
          isCloseApp: true,
          //提示文案
          permissionList: _list,
        ),
        //权限申请结果
        dismissCallBack: (value) {
          //插值
          LogUtils.e("权限申请结果 $value");

          initDataNext();
        });
  }

  //初始化工具类
  void initDataNext() async {
    if (Platform.isIOS) {
      Directory libDire = await getLibraryDirectory();
      LogUtils.e("libDire ${libDire.path}");
    }
    //初始化
    await SPUtil.init();
    //读取一下标识
    bool isAgrement = await SPUtil.getBool("isAgrement");

    LogUtils.e("isAgrement $isAgrement");

    UserHepler.getInstance.init();

    if (isAgrement == null || !isAgrement) {
      isAgrement = await showProtocolFunction(context);
    }

    if (isAgrement) {
      //同意
      LogUtils.e("同意协议");

      //保存一下标识
      SPUtil.save("isAgrement", true);

      next();
    } else {
      LogUtils.e("不同意");
      closeApp();
    }
  }

  void closeApp() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }

  void next() async {

    //判断是否第一次安装应用
    bool isFirstInstall = await  SPUtil.getBool("flutter_ho_isFirst");

    if(isFirstInstall==null){
      //如果为null 则是第一次安装应用
      //引导 页面
      NavigatorUtils.pushPageByFade(
          context: context, targPage: FirstGuildPage(), isReplace: true);
    }else{
      //倒计时页面
      NavigatorUtils.pushPageByFade(
          context: context, targPage: WelcomePage(), isReplace: true);
    }

  }
}
