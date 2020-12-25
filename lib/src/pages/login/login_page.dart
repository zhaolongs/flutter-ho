import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:flutter_ho/src/utils/toast_utils.dart';

import 'bg/bubble_widget.dart';
import 'custom_textfield_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/24.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //密码输入框焦点控制
  FocusNode _passwordFocusNode = new FocusNode();
  //手机号输入框焦点控制
  FocusNode _userNameFocusNode = new FocusNode();

  //手机号输入框控制器
  TextEditingController _userNameEditController = new TextEditingController();
  //密码输入框控制器
  TextEditingController _userPasswordEditController =
      new TextEditingController();

  //控制密码显示
  bool _passwordShow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //输入框预设内容
    _userNameEditController.text= "12345678901";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///填充布局
      body: Container(
          width: double.infinity,
          height: double.infinity,
          //点击空白区域 隐藏键盘
          child: GestureDetector(
            onTap: (){
              _userNameFocusNode.unfocus();
              _passwordFocusNode.unfocus();
            },
            child: Stack(
              children: [
                //第一层 背景
                buildBackgroundWidget(),
                //第二层 气泡
                Positioned.fill(child: BubbleWidget(),),
                //第三层 高斯模糊
                buildFliterWidget(),
                //第四层 logo
                buildLogoWidget(),
                //第五层来个输入层
                //buildInputWidget(context),
                //第六层 关闭按钮
                //buildCloseWidget(context)
              ],
            ),
          )),
    );
  }








  Positioned buildInputWidget(BuildContext context) {
    return Positioned(
                bottom: 60,
                right: 60,
                left: 60,
                child: Column(
                  children: [
                    //手机号
                    TextFieldWidget(
                      hintText: "手机号",
                      submit: (value) {
                        if(value.length!=11){
                          ToastUtils.showToast("请输入11位手机号");
                          FocusScope.of(context).requestFocus(_userNameFocusNode);
                          return;
                        }
                        _userNameFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      focusNode: _userNameFocusNode,
                      prefixIconData: Icons.phone,
                      controller: _userNameEditController,
                      obscureText: false,
                    ),
                    SizedBox(height: 40,),
                    //密码

                    TextFieldWidget(
                      hintText: "密码",
                      submit: (value) {},
                      focusNode: _passwordFocusNode,
                      prefixIconData: Icons.lock_open_outlined,
                      suffixIconData: _passwordShow?Icons.visibility:Icons.visibility_off,
                      obscureText: _passwordShow,
                      controller: _userPasswordEditController,
                      onTap: (){
                        setState(() {
                          _passwordShow=!_passwordShow;
                        });
                      },
                    ),
                    SizedBox(height: 40,),

                    //登录
                    Container(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          LogUtils.e("点击了登录");
                        },
                        child: Text(
                          "登录",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //注册
                    Container(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          LogUtils.e("点击了注册");
                        },
                        child: Text(
                          "注册",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              );
  }

  ///第六层 关闭按钮
  Positioned buildCloseWidget(BuildContext context) {
    return Positioned(
      left: 10,
      top: 64,
      child: CloseButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  ///第一层 背景
  Positioned buildBackgroundWidget() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          //线性渐变
          gradient: LinearGradient(
            //渐变的开始方向
            begin: Alignment.topLeft,
            //渐变的结束方向
            end: Alignment.bottomRight,
            //渐变的颜色组 最少为两个
            colors: [
              Colors.lightBlueAccent.withOpacity(0.3),
              Colors.blue.withOpacity(0.3),
            ],
          ),
        ),
      ),
    );
  }

  ///高斯模糊
  Positioned buildFliterWidget() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 0.3, sigmaX: 0.3),
        child: Container(
          color: Colors.white.withOpacity(0.3),
        ),
      ),
    );
  }

  //第三层 logo
  Positioned buildLogoWidget() {
    return Positioned(
      top: 120,
      left: 0,
      right: 0,
      child: Row(
        //子Widget水平居中
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: "logo",
            child: Material(
              color: Colors.transparent,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/app_icon.png",
                  width: 33,
                  height: 33,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '欢迎登录',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey),
          )
        ],
      ),
    );
  }
}
