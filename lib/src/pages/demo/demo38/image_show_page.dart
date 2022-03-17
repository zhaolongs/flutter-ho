// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_drag_scale_widget/flutter_drag_scale_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: TestPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildRow(),
      ),
    );
  }

  final List<String> _imageList = [
    "assets/images/banner1.png",
    "assets/images/banner2.png",
    "assets/images/banner3.png"
  ];

  Widget buildRow() {
    return ImageShowPageView(
      //图片数据
      imageList: _imageList,
      //图片的类型
      imageShowType: ImageShowType.ASSET,
      //图片的填充方式
      boxFit: BoxFit.contain,
      onPageChanged: (int index) {
        //滑动回调
      },
    );
  }
}
