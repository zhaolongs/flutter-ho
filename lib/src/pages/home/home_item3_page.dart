import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/bean/bean_art.dart';
import 'package:flutter_ho/src/net/dio_utils.dart';
import 'package:flutter_ho/src/utils/toast_utils.dart';

import 'home_art_list_item_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/3.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///

class HomeItem3Page extends StatefulWidget {
  @override
  _HomeItem3PageState createState() => _HomeItem3PageState();
}

class _HomeItem3PageState extends State<HomeItem3Page> {
  //列表数据
  List<ArtBean> _artBeanList = [];

  @override
  void initState() {
    super.initState();
    loadingNetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的文章列表"),
      ),
      backgroundColor: Color(0XffCDDEEC),

      //下拉刷新
      body: RefreshIndicator(
        //懒加载
        onRefresh: () {
          return onRefresh();
        },
        child: ListView.builder(
          //列表的个数
          itemCount: _artBeanList.length,
          //列表的每个子Item 的样式
          itemBuilder: (BuildContext context, int index) {
            ArtBean artBean = _artBeanList[index];
            return HomeItemArtWidget(artBean: artBean);
          },
        ),
      ),
    );
  }

  ///异步加载
  void loadingNetData() async {
    /*
    {
    "code": 200,
    "data": [
        {
            "id": 3,
            "title": "JS 雪花飘落效果 玩转 canvas 绘图 码农的每日积累 -匠心之作",
            "url": "https://zhuanlan.zhihu.com/p/327699543",
            "image": "https://img-blog.csdnimg.cn/20201128105150457.gif#pic_center",
            "readCount": 232,
            "pariseCount": 111,
            "createTime": "2020-01-09T21:17:49.000+0000"
        },
      ],
    }
     */
    //发起一个post 请求
    ResponseInfo responseInfo =
        await DioUtils.instance.getRequest(url: HttpHelper.artList);
    if (responseInfo.success) {
      List list = responseInfo.data;
      //清空一下数据
      _artBeanList = [];
      list.forEach((element) {
        _artBeanList.add(ArtBean.fromMap(element));
      });
      setState(() {});
    } else {
      ToastUtils.showToast("请求失败");
    }
  }

  int _preLoadingTime = 0;

  //下拉刷新
  Future<bool> onRefresh() async {
    //记录开始加载的时间
    _preLoadingTime = DateTime.now().microsecond;
    //加载数据
    await loadingNetData();
    //加载完的时间
    int current = DateTime.now().microsecond;
    //时间差
    int flagTime = current - _preLoadingTime;
    //最少显示1秒
    if (flagTime < 1000) {
      await Future.delayed(Duration(milliseconds: 1000-flagTime));
    }
    ToastUtils.showToast("已刷新");
    return true;
  }
}
