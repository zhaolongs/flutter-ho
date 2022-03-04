import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/9.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

class NavigatorUtils {
  ///普通打开页面的方法
  ///[context] 上下文对象
  ///[targPage] 目标页面
  ///[isReplace] 是否替换当前页面  A -B
  static void pushPage({
    required BuildContext context,
    required Widget targPage,
    bool isReplace = false,
    Function(dynamic value)? dismissCallBack,
  }) {
    PageRoute pageRoute;

    if (Platform.isAndroid) {
      pageRoute = MaterialPageRoute(builder: (BuildContext context) {
        return targPage;
      });
    } else {
      pageRoute = CupertinoPageRoute(builder: (BuildContext context) {
        return targPage;
      });
    }

    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  ///普通打开页面的方法
  ///[context] 上下文对象
  ///[targPage] 目标页面
  ///[isReplace] 是否替换当前页面  A -B
  ///[opaque] 是否以背景透明的方式打开页面
  static void pushPageByFade({
    required BuildContext context,
    required Widget targPage,
    bool isReplace = false,
    int startMills = 400,
    bool opaque = false,
    Function(dynamic value)? dismissCallBack,
  }) {
    PageRoute pageRoute = PageRouteBuilder(
      //背景透明 方式打开新的页面
      opaque: opaque,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return targPage;
      },
      transitionDuration: Duration(milliseconds: startMills),
      //动画
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );

    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  ///中间缩放的形式打开页面
  /// 开源项目  Flutter-HO 早起的年轻人
  /// github https://github.com/zhaolongs/flutter-ho
  static void pushPageByCenterScale({
    required BuildContext context,
    required Widget targPage,
    bool isReplace = false,
    int startMills = 400,
    int reversMills = 400,
    bool opaque = false,
    Function(dynamic value)? dismissCallBack,
  }) {
    if (isReplace) {
      Navigator.of(context)
          .pushReplacement(
              _createRoute(context, targPage, startMills, reversMills))
          .then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      Navigator.of(context)
          .push(_createRoute(context, targPage, startMills, reversMills))
          .then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  static Route _createRoute(BuildContext parentContext, Widget targPage,
      int startMills, int reversMills) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) {
        return targPage;
      },
      transitionDuration: Duration(milliseconds: startMills),
      reverseTransitionDuration: Duration(milliseconds: reversMills),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rectAnimation = _createTween(parentContext)
            .chain(CurveTween(curve: Curves.ease))
            .animate(animation);

        return Stack(
          children: [
            PositionedTransition(rect: rectAnimation, child: child),
          ],
        );
      },
    );
  }

  static Tween<RelativeRect> _createTween(BuildContext context) {
    var windowSize = MediaQuery.of(context).size;
    var box = context.findRenderObject() as RenderBox;
    var rect = box.localToGlobal(Offset.zero) & box.size;
    var relativeRect = RelativeRect.fromSize(rect, windowSize);

    return RelativeRectTween(
      begin: relativeRect,
      end: RelativeRect.fill,
    );
  }
}
