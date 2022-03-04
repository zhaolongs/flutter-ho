import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/demo3/GridViewBean.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';

import 'GridViewItemWidget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/2/7.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
main() {
  runApp(MaterialApp(
    home: GridViewDemoPage(),
  ));
}

///代码清单
class GridViewDemoPage extends StatefulWidget {
  @override
  _GridViewDemoPageState createState() => _GridViewDemoPageState();
}

class _GridViewDemoPageState extends State<GridViewDemoPage> {
  //数据源
  List<GridBean> _list = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      GridBean gridBean = new GridBean(title: "测试$i");
      _list.add(gridBean);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView "),
        actions: [
          TextButton(
            onPressed: () {
              //获取完成的数据
              //获取选中的数据
              List<String> selectList = [];

              //筛选数据
              _list.forEach((GridBean element) {
                //选中标识
                if(element.isSelect){
                  selectList.add(element.title);
                }
              });

              LogUtils.e("${selectList.toString()}");

            },
            child: Text(
              "提交数据",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: GridView.builder(
        //子Item的个数
        itemCount: _list.length,
        //子布局构建器
        itemBuilder: (BuildContext context, int index) {
          //取出每个数据
          GridBean bean = _list[index];

          return GridViewItemWidget(bean:bean);
        },
        //子布局排列方式
        //按照固定列数来排列
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //主方向的Item间隔 竖直方向
          mainAxisSpacing: 12,
          //次方向的Item间隔
          crossAxisSpacing: 12,
          //子Item 的宽高比
          childAspectRatio: 2.1,
          //每行4列
          crossAxisCount: 4,
        ),
      ),
    );
  }
}
