import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/12.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class CommonWebViewPage extends StatefulWidget {
  final String htmlUrl;
  final String pageTitle;

  CommonWebViewPage({@required this.htmlUrl, this.pageTitle = ""});

  @override
  _CommonWebViewPageState createState() => _CommonWebViewPageState();
}

class _CommonWebViewPageState extends State<CommonWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.pageTitle}"),
      ),
      backgroundColor: Colors.white,
      body: WebView(
        initialUrl: widget.htmlUrl,
      ),
    );
  }
}
