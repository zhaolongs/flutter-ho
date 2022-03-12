// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

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

  Row buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/test_icon.png", width: 100),
        const SizedBox(width: 55),
        ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                colors: [Colors.grey, Colors.black],
              ).createShader(bounds);
            },
            child: Image.asset("assets/images/test_icon.png", width: 100)),
      ],
    );
  }
}
