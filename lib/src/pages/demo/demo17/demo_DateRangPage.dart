import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    //不显示 debug标签
    debugShowCheckedModeBanner: false,
    //当前运行环境配置
    locale: Locale("zh", "CH"),
    //程序支持的语言环境配置
    supportedLocales: [Locale("zh", "CH")],
    //Material 风格代理配置
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    //显示的首页面
    home: DemoDateRangPage(),
  ));
}

///代码清单
class DemoDateRangPage extends StatefulWidget {
  @override
  _DemoDateRangPageState createState() => _DemoDateRangPageState();
}

class _DemoDateRangPageState extends State<DemoDateRangPage> {
  late String _dateSelectText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("日期范围选择"),
      ),
      body: Center(
        child: Text("当前选择 $_dateSelectText"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDateSelect();
        },
        child: Icon(Icons.select_all),
      ),
    );
  }

  void showDateSelect() async {
    //获取当前的时间
    DateTime start = DateTime.now();
    //在当前的时间上多添加4天
    DateTime end = DateTime(start.year, start.month, start.day + 4);

    //显示时间选择器
    DateTimeRange? selectTimeRange = await showDateRangePicker(
        //语言环境
        locale: Locale("zh", "CH"),
        context: context,
        //开始时间
        firstDate: DateTime(2020, 1),
        //结束时间
        lastDate: DateTime(2022, 1),
        cancelText: "取消",
        confirmText: "确定",
        //初始的时间范围选择
        initialDateRange: DateTimeRange(start: start, end: end));
    if (selectTimeRange != null) {
      //结果
      _dateSelectText = selectTimeRange.toString();
      //选择结果中的开始时间
      DateTime selectStart = selectTimeRange.start;
      //选择结果中的结束时间
      DateTime selectEnd = selectTimeRange.end;

      setState(() {});
    }
  }
}
