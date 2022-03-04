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
class VideoDetails2Widget extends StatefulWidget {
  final StreamController streamController;

  VideoDetails2Widget({required this.streamController});

  @override
  _VideoDetailsWidgetState createState() => _VideoDetailsWidgetState();
}

class _VideoDetailsWidgetState extends State<VideoDetails2Widget> {
  //创建视频播放控制器
  late VideoPlayerController _controller;
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

    //视频播放的实时更新
    _controller.addListener(() {
      if (_isPlay && !_controller.value.isPlaying) {
        _isPlay = false;
        setState(() {});
      }

      //视频播放的当前时间进度
      Duration currentDuration = _controller.value.position;
      //视频的总时长
      Duration totalDuration = _controller.value.duration;

      //滑动条进度
      _currentSlider =
          currentDuration.inMilliseconds / totalDuration.inMilliseconds;
      if (_opacity == 1.0) {
        _streamController.add(0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _streamController.close();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
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

  Timer? _timer;
  double _opacity = 1.0;
  bool _isFirst = true;

  Widget buildControllerWidget() {
    //动画过渡透明度组件
    return AnimatedOpacity(
      //过渡时间
      duration: Duration(milliseconds: 1200),
      opacity: _opacity,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _opacity = 1.0;
          });
          //创建一个延时执行的定时 器
          _timer = Timer(Duration(seconds: 3), () {
            setState(() {
              _opacity = 0.0;
            });
          });
        },
        child: Stack(
          children: [
            //层叠布局中的填充
            Positioned.fill(
              child: Container(
                //底部内边距
                padding: EdgeInsets.only(bottom: 40),
                //0.3 的蓝色透明度
                color: Colors.blueGrey.withOpacity(0.5),
                //手势监听
                child: GestureDetector(
                  //手指抬起后的回调
                  onTap: controllerClickFunction,
                  //层叠布局
                  child: Stack(
                    //子Widget居中对齐
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: 54,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: RadialGradient(colors: [
                            Colors.black,
                            Colors.black.withOpacity(0.3),
                          ])),
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow_sharp,
                            size: 33,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //顶部对齐的文本
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              height: 44,
              child: Text(
                "早起的年轻人",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            //底部的滑动条
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              height: 60,
              child: buildBottomController(),
            )
          ],
        ),
      ),
    );
  }

  ///控制层点击事件
  void controllerClickFunction() {
    //获取当前视频是否在播放
    bool isPlaying = _controller.value.isPlaying;
    if (isPlaying) {
      //如果视频正在播放中 再次点击停止播放
      stopVideo();
      //停止播放状态下 取消隐藏的计时器
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
    } else {
      //开始播放视频
      startPlayVide();
      //创建一个延时执行的定时器
      _timer = Timer(Duration(seconds: 3), () {
        //3秒后将控制层的透明度设置为0
        //控制层还在
        setState(() {
          _opacity = 0.0;
        });
      });
    }
  }

  ///开始播放视频
  void startPlayVide() {
    _isPlay = true;
    _isFirst = false;
    //发送消息
    //先暂停再播放
    if (widget.streamController != null) {
      widget.streamController.add(_controller);
    }

    //当前视频 播放的位置
    Duration postion = _controller.value.position;
    //视频的总长度
    Duration duration = _controller.value.duration;

    if (postion == duration) {
      //播放完毕 再点击播放时，当播放位置滑动到开始位置
      _controller.seekTo(Duration.zero);
    }
    //开始播放
    _controller.play();

    setState(() {});
  }

  double _currentSlider = 0.0;
  StreamController<int> _streamController = new StreamController();

  buildBottomController() {
    if (_isFirst) {
      return Container();
    }
    //评论区有文章回复支持
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Row(
          children: [
            Text(
              buildStartText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            Expanded(
              child: Slider(
                //滑动条当前的进度
                value: _currentSlider,
                //滑动条滑动时的回调
                onChanged: (value) {
                  setState(() {
                    _currentSlider = value;
                    //控制视频
                    _controller.seekTo(_controller.value.duration * value);
                  });
                },
                min: 0.0,
                max: 1.0,
                //滑动条的底色
                inactiveColor: Colors.white,
                //滑动条的进度颜色
                activeColor: Colors.redAccent,
              ),
            ),
            Text(
              buildEndText(),
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        );
      },
    );
  }

  //获取时实播放的时间
  String buildStartText() {
    //视频当前的播放进度
    Duration duration = _controller.value.position;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }

    return "$mStr:$sStr";
  }

  String buildEndText() {
    //视频总的时长
    Duration duration = _controller.value.duration;
    int m = duration.inMinutes;
    int s = duration.inSeconds;

    String mStr = "$m";
    if (m < 10) {
      mStr = "0$m";
    }
    String sStr = "$s";
    if (s < 10) {
      sStr = "0$s";
    }

    return "$mStr:$sStr";
  }

  ///停止播放视频
  void stopVideo() {
    //视频播放控制器停止播放
    _controller.pause();
    //变量标识
    _isPlay = false;
  }
}
