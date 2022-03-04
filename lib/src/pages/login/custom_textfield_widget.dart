import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/25.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
///自定义文本输入框
class TextFieldWidget extends StatelessWidget {
  //占位提示文本
  final String? hintText;

  //输入框前置图标
  final IconData? prefixIconData;

  //输入框后置图标
  final IconData? suffixIconData;

  //是否隐藏文本
  final bool? obscureText;

  //输入实时回调
  final Function(String value)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String value)? submit;
  final Function()? onTap;

  TextFieldWidget({
    Key? key,
    this.hintText,
    this.submit,
    this.focusNode,
    this.prefixIconData,
    this.suffixIconData,
    this.obscureText,
    this.onChanged,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //构建输入框
    return TextField(
      focusNode: focusNode,
      controller: controller,
      //实时输入回调
      onChanged: onChanged,
      onSubmitted: submit,
      //是否隐藏文本
      obscureText: obscureText ?? false,
      //隐藏文本小圆点的颜色
      cursorColor: Theme.of(context).accentColor,
      //文本样式
      style: TextStyle(
        color: Theme.of(context).accentColor,
        fontSize: 14.0,
      ),
      //输入框的边框
      decoration: InputDecoration(
        //提示文本
        labelText: hintText,
        //提示文本的样式
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        //可编辑时的提示文本的颜色
        focusColor: Theme.of(context).accentColor,
        //填充
        filled: true,
        //可编辑时 无边框样式
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),

        //获取输入焦点时的边框样式
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),

        //文本前置的图标
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Theme.of(context).accentColor,
        ),
        //文本后置的图标
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            suffixIconData,
            size: 18,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
