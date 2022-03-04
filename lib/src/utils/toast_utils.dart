import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///lib/utils/toast_utils.dart
///Toast工具类
class ToastUtils {
  static void showToast(String message) {
    // 根据消息长度决定自动消失时间
    double multiplier = 0.5;
    double flag = message.length * 0.06 + 0.5;
    //计算显示时间
    int timeInSecForIos = (multiplier * flag).round();
    //如果已显示 先取消已有的
    Fluttertoast.cancel();
    //显示Toast
    Fluttertoast.showToast(
      backgroundColor: Colors.black54,
      msg: message,
      //显示的位置
      gravity: ToastGravity.CENTER,
      //只针对iOS生效的消失时间
      timeInSecForIosWeb: timeInSecForIos,
    );
  }
}
