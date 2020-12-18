import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';


/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/18.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
/// 
/// 代码清单 
///代码清单
class VideoDetailsWidget extends StatefulWidget {
  final StreamController streamController;

  VideoDetailsWidget({this.streamController});

  @override
  _VideoDetailsWidgetState createState() => _VideoDetailsWidgetState();
}

class _VideoDetailsWidgetState extends State<VideoDetailsWidget> {
  //创建视频播放控制器
  VideoPlayerController _controller;
  bool _isPlay = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/list_item.mp4')
      ..initialize().then((_) {
        LogUtils.e("加载完成");
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      if (_isPlay && !_controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //第一层的视频
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              _controller.pause();
              _isPlay = false;
              setState(() {});
            },
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        ),

        //第二层的控制按钮
        buildControllerWidget()
      ],
    );
  }


  Widget buildControllerWidget() {
    if (_isPlay) {
      //如果正在播放
      return Container();
    }
    return Positioned.fill(
      child: Container(
        //0.3 的蓝色透明度
        color: Colors.blueGrey.withOpacity(0.5),
        //图标
        child: GestureDetector(
          onTap: () {
            _isPlay = true;
            //发送消息
            //先暂停再播放
            if (widget.streamController != null) {
              widget.streamController.add(_controller);
            }
            _controller.play();

            setState(() {});
          },
          child: Icon(
            Icons.play_circle_fill,
            size: 44,
          ),
        ),
      ),
    );
  }

}