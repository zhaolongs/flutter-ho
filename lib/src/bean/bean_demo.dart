import 'package:flutter/material.dart';

class DemoBean {
  String title = '';
  String content = '';
  String time = '';
  Widget page;

  DemoBean.name(
      {required this.title,
      this.time = "",
      this.content = '',
      required this.page});
}
