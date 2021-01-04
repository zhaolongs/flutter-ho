import 'package:flutter_ho/src/bean/bean_user.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class ArtBean {
  //文章标题
  String artTitle;
  //文章简介
  String artInfo;
  //喜欢个数
  int likeCount;
  //评论个数
  int pariseCount;
  //用户数据
  UserBean userBean;
  //创建时间
  String createTime;

  ///常用用于解析JSON数据
  ArtBean.fromMap(Map<String, dynamic> map) {
    this.artTitle = map["title"];
    this.artInfo = map["artInfo"];

    this.likeCount = map["readCount"];
    this.pariseCount = map["pariseCount"];
    this.createTime = map['createTime'];

    var bean = map["user"];
    if (bean != null) {
      userBean = UserBean.fromMap(bean);
    }
  }

}
