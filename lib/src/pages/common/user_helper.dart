import 'package:flutter_ho/src/bean/bean_user.dart';
import 'package:flutter_ho/src/utils/sp_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/23.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class UserHepler {
  //私有化构造函数
  UserHepler._() {}

  //创建全局单例对象
  static UserHepler getInstance = UserHepler._();

  UserBean? _userBean;

  //是否登录
  bool get isLogin => _userBean != null;

  set userBean(UserBean bean) {
    _userBean = bean;
    SPUtil.saveObject("user_bean", _userBean);
  }

  void init() {
    Map<String, dynamic>? map = SPUtil.getObject("user_bean");
    if (map != null) {
      //加载缓存
      _userBean = UserBean.fromMap(map);
    }
  }

  void clear() {
    _userBean = null;
    SPUtil.remove("user_bean");
  }
}
