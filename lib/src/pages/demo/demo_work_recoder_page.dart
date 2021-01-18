import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/date_utils.dart';
/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/18.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class MineWorkRecoderPage extends StatefulWidget {
  @override
  _MineWorkRecoderPageState createState() => _MineWorkRecoderPageState();
}

class _MineWorkRecoderPageState extends State<MineWorkRecoderPage> {
  List<WorkBean> _list = [
    WorkBean("部门经理", "内部调岗", "2021-01-01 20:00:00"),
    WorkBean("基层科员", "岗位升职", "2020-01-01 20:00:00"),
    WorkBean("基层安装", "新入职", "2019-10-01 20:00:00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("成长记录"),
      ),
      backgroundColor: Colors.white,

      ///填充布局
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: ListView.builder(
          //Item数量
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return buildListItemWidget(index);
          },
        ),
      ),
    );
  }

  Widget buildListItemWidget(int index) {
    WorkBean workBean = _list[index];
    return Container(
      height: 100,
      child: Row(
        children: [
          //第一列的日期
          buildLeftDate(workBean),
          //第二列的竖线
          buildMiddleLien(index),
          //第三列的职位信息
          buildWorkWidget(index),
        ],
      ),
    );
  }

  Widget buildLeftDate(WorkBean workBean) {
    return Container(
      width: 60,
      margin: EdgeInsets.only(left: 80, right: 10),
      child: Column(
        children: [
          Text(
            "${DateUtils.formatDateStr(workBean.workDate, format: "yyyy")}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff666666),
            ),
          ),
          Text(
            "${DateUtils.formatDateStr(workBean.workDate, format: "MM-dd")}",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff666666),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMiddleLien(int index) {
    Color color = Colors.green;
    if (index != 0) {
      color = Colors.grey[200];
    }
    return Column(
      children: [
        SizedBox(
          height: 4,
        ),
        ClipOval(
          child: Container(
            width: 6,
            height: 6,
            color: color,
          ),
        ),
        Expanded(
          child: Container(
            width: 1,
            color: index == _list.length - 1
                ? Colors.transparent
                : Colors.grey[300],
          ),
        )
      ],
    );
  }

  buildWorkWidget(int index) {
    WorkBean workBean = _list[index];
    return Container(
      margin: EdgeInsets.only(left: 12),
      child: Column(
        children: [
          Text(
            "${workBean.work}",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xff666666),
            ),
          ),
          Text(
            "${workBean.workFlag}",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff666666),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkBean {
  //工作名称
  String work;

  //工作部门
  String workFlag;

  //变更日期
  String workDate;

  WorkBean(this.work, this.workFlag, this.workDate);
}
