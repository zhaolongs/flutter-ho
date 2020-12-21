import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

import 'list_item2_widget.dart';
import 'list_item_widget.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/14.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HomeItemPage extends StatefulWidget {
  final int flag;

  HomeItemPage(this.flag);

  @override
  _HomeItemPageState createState() => _HomeItemPageState();
}

class _HomeItemPageState extends State<HomeItemPage> {
  //创建一个多订阅流
  StreamController<VideoPlayerController> _streamController =
      StreamController.broadcast();

  //当前播放视频的控制器
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    //添加一个消息监听
    _streamController.stream.listen((event) {
      LogUtils.e("接收到消息 ${event.textureId}");
      if (_videoPlayerController != null &&
          _videoPlayerController.textureId != event.textureId) {
        _videoPlayerController.pause();
      }
      _videoPlayerController = event;
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  bool _isScroll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      backgroundColor: Colors.grey[200],
      body: NotificationListener(
        onNotification: (ScrollNotification notification) {
          Type runtimType = notification.runtimeType;

          LogUtils.e("runtimType $runtimType");
          if (runtimType == ScrollStartNotification) {
            LogUtils.e("开始滑动");
            _isScroll = true;
          } else if (runtimType == ScrollEndNotification) {
            LogUtils.e("结束滑动");
            _isScroll = false;
            setState(() {});
          }

          return false;
        },
        child: ListView.builder(
          //缓存距离为0
          cacheExtent: 0,
          itemCount: 100,
          itemBuilder: (BuildContext context, int index) {
            return buildListItemFungion();
          },
        ),
      ),
    );
  }

  Widget buildListItemFungion() {
    if(widget.flag==1){
      return ListViewItemWidget(
        isScroll: _isScroll,
        streamController: _streamController,
      );
    }else{
      return ListViewItem2Widget(
        isScroll: _isScroll,
        streamController: _streamController,
      );
    }
  }
}
