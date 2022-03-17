// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_drag_scale_widget/flutter_drag_scale_widget.dart';

void main() {
  runApp(
    MaterialApp(
      home: LayoutBuilderPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class LayoutBuilderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {

          double maxWidth = constraints.maxWidth;
          double minWidth = constraints.minWidth;

          double maxHeight = constraints.maxHeight;
          double minHeight = constraints.minHeight;
          if(maxWidth>400) {
            return buildRow();
          }
          return buildColumn();
        },),
      ),
    );
  }

  Widget buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("右侧按钮")),
        SizedBox(width: 60,),
        ElevatedButton(onPressed: () {}, child: Text("左侧按钮")),
      ],
    );
  }

  Widget buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {}, child: Text("右侧按钮")),
        SizedBox(height: 60,),
        ElevatedButton(onPressed: () {}, child: Text("左侧按钮")),
      ],
    );
  }
}
