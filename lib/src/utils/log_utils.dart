


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/10.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单
class LogUtils {

  //是否输入日志标识
  static bool _isLog = true;
  static String _logFlag = "Flutter-Ho";

  static void init({bool islog = false,String logFlag ="Flutter-Ho"}){
    _isLog = islog;
    _logFlag = logFlag;
  }


  static void e(String message){

    if(_isLog){
      print("$_logFlag | $message");
    }
  }

}