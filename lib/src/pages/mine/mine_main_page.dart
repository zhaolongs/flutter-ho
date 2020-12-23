import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/common/user_helper.dart';

import 'mine_login_page.dart';
import 'mine_no_login_page.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///个人中心页面
class MineMainPage extends StatefulWidget {
  @override
  _MineMainPageState createState() => _MineMainPageState();
}

class _MineMainPageState extends State<MineMainPage> {

  @override
  Widget build(BuildContext context) {
    //判断用户是否已登录
    if(UserHepler.getInstance.isLogin){
      //构建已登录的页面
      return MineLoginPage();
    }else{
      //构建未登录的页面
      return MineNoLoginPage();
    }
  }

}