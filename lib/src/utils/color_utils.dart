import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/6/26.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// gongzhonghao biglead
/// https://study.163.com/instructor/1021406098.htm
/// https://blog.csdn.net/zl18603543572
/// https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/

///颜色工具类
///lib/utils/color_utils.dart
class ColorUtils {
  ///获取随机颜色
  static Color getRandomColor() {
    return Color.fromARGB(255, Random.secure().nextInt(200),
        Random.secure().nextInt(200), Random.secure().nextInt(200));
  }

  ///十六进制记法  #FF000000  取值范围为：00 - FF。
  ///RGB色彩是通过对红(R)、绿(G)、蓝(B)
  ///   三个颜色通道的变化和它们相互之间的叠加来得到各式各样的颜色的。
  ///RGBA此色彩模式与RGB相同，只是在RGB模式上新增了Alpha透明度。

  ///获取随机透明的白色
  static Color getRandonWhightColor(Random random) {
    //0~255 0为完全透明 255 为不透明
    //这里生成的透明度取值范围为 10~200
    int a = random.nextInt(190) + 10;
    return Color.fromARGB(a, 255, 255, 255);
  }
}
