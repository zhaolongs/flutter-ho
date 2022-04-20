import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    home: DemoFormPage(),
  ));
}

///代码清单
class DemoFormPage extends StatefulWidget {
  @override
  _DemoFormPageState createState() => _DemoFormPageState();
}

class _DemoFormPageState extends State<DemoFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(12),
          child: buildFormWidget(),
        ),
      ),
    );
  }

  final _formKey = new GlobalKey<FormState>();

  buildFormWidget() {
    return Form(
      key: _formKey,
      child: buildColumn(),
    );
  }

  String? _name;
  String? _password;

  buildColumn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //用户名
        TextFormField(
          decoration: InputDecoration(hintText: "请输入用户名"),
          onSaved: (value) {
            _name = value;
          },
          validator: (String? value) {
            return value != null && value.length > 6 ? null : "账号最少6个字符";
          },
        ),
        //密码
        TextFormField(
          decoration: InputDecoration(hintText: "请输入密码"),
          onSaved: (value) {
            _password = value;
          },
          obscureText: true,
          validator: (String? value) {
            return value != null && value.length > 6 ? null : "密码最少6个字符";
          },
        ),
        //按钮
        Row(
          children: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState != null) {
                    _formKey.currentState!.reset();
                  }
                },
                child: Text("重置")),
            TextButton(
                onPressed: () {
                  //校验
                  if (_formKey.currentState != null) {
                    if (_formKey.currentState!.validate()) {
                      //获取值
                      _formKey.currentState!.save();
                      print("调用接口 $_name $_password");
                    }
                  }
                },
                child: Text("登录"))
          ],
        )
      ],
    );
  }
}
