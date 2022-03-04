import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
///
///
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //显示的首页面
    home: DemoMouseRegionPage(),
  ));
}

///代码清单
class DemoMouseRegionPage extends StatefulWidget {
  @override
  _DemoMouseRegionPageState createState() => _DemoMouseRegionPageState();
}

class _DemoMouseRegionPageState extends State<DemoMouseRegionPage> {
  bool _isSign = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("签名"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print("全屏");
                        },
                        child: Container(
                          child: Icon(Icons.expand),
                        ),
                      )
                    ],
                  ),
                  buildContainer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          print("清除");
                          _signatureController.clear();
                        },
                        child: Container(
                          child: Icon(Icons.clear),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  //生成 图片
                  _signatureController.toImage();
                },
                child: Text("保存")),
          ],
        ),
      ),
    );
  }

  SignatureController _signatureController = SignatureController(
    //线条宽度
    penStrokeWidth: 1,
    //线条颜色
    penColor: Colors.red,
  );

  Widget buildContainer() {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Offstage(
            offstage: _isSign,
            child: Text(
              "签名",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey,
                fontSize: 25,
              ),
            ),
          ),
          Signature(
            controller: _signatureController,
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
