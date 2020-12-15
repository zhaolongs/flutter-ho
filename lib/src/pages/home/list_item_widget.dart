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
/// 代码清单
///代码清单
class ListViewItemWidget extends StatefulWidget {
  @override
  _ListViewItemWidgetState createState() => _ListViewItemWidgetState();
}

class _ListViewItemWidgetState extends State<ListViewItemWidget> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [Icon(Icons.one_k), Text("早起的年轻人")],
          ),
          SizedBox(height: 8,),
          Container(
            height: 220,
            child: Stack(
              children: [
                //第一层的视频
                Positioned.fill(
                  child: GestureDetector(
                    onTap: (){
                      _controller.pause();
                      _isPlay=false;
                      setState(() {

                      });
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
            ),
          )
        ],
      ),
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
            _isPlay=true;
            _controller.play();
            setState(() {

            });
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
