

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/7/23.
///
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/9/25.
///
/// gongzhonghao biglead
/// https://study.163.com/instructor/1021406098.htm
/// https://blog.csdn.net/zl18603543572
/// https://www.toutiao.com/c/user/token/MS4wLjABAAAAYMrKikomuQJ4d-cPaeBqtAK2cQY697Pv9xIyyDhtwIM/


class AppVersionBean {
  bool isNeed;
  String isForce;
  String updateContent;
  String packageUrl;

  AppVersionBean.fromJson(Map<String, dynamic> map) {
    this.isNeed = map["isNeed"];
    this.isForce = map["isForce"];
    this.updateContent = map["updateContent"];
    this.packageUrl = map["packageUrl"];
  }
}

