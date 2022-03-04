import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:video_player/video_player.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2020/12/14.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
// 倒计时页面 的视频播放
class WelcomeVideoWidget extends StatefulWidget {
  @override
  _WelcomeVideoWidgetState createState() => _WelcomeVideoWidgetState();
}

class _WelcomeVideoWidgetState extends State<WelcomeVideoWidget> {
  //创建视频播放控制器
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/video/welcom.mp4')
      ..initialize().then((_) {
        LogUtils.e("加载完成");
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
