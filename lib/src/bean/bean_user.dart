/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class UserBean {
  String userName;
  int userAge;

  ///常用用于解析JSON数据
  UserBean.fromMap(Map<String, dynamic> map) {
    this.userName = map["userName"];
    this.userAge = map["age"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();
    map["userName"] = this.userName;
    map["userAge"] = this.userAge;
    return map;
  }
}
