import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/pages/demo/demo1/targ_image_page.dart';
import 'package:flutter_ho/src/utils/log_utils.dart';
import 'package:flutter_ho/src/utils/navigator_utils.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/24.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///图片浏览器
class ImageScanWidget extends StatefulWidget {
  final List<String> imageList;

  const ImageScanWidget({Key? key, required this.imageList}) : super(key: key);

  @override
  _ImageScanWidgetState createState() => _ImageScanWidgetState();
}

class _ImageScanWidgetState extends State<ImageScanWidget> {
  //当前显示的图片
  int _index = 0;

  //滑动控制器
  PageController _scrollController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      //获取滑动距离
      double offset = _scrollController.offset;
      //获取最大可滑动距离
      double maxOffset = _scrollController.position.maxScrollExtent;
      if (offset > maxOffset + 10) {
        //退出当前页面 问题是连续执行了两次
        //Navigator.of(context).pop();
      }
      //LogUtils.e("offset $offset - maxOffset $maxOffset");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.withOpacity(0.9),

      ///填充布局
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            //滑动
            buildListener(context),
            //索引
            Positioned(
              bottom: 40,
              right: 40,
              child: Text("${_index + 1}/${widget.imageList.length + 1}"),
            )
          ],
        ),
      ),
    );
  }

  Listener buildListener(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        LogUtils.e("onPointerDown");
      },
      onPointerCancel: (PointerCancelEvent event) {
        LogUtils.e("onPointerCancel");
        nextFunction(context);
      },
      onPointerUp: (PointerUpEvent event) {
        LogUtils.e("onPointerUp");
        //替换一个新的页面
        nextFunction(context);
      },
      child: buildPageView(),
    );
  }

  void nextFunction(BuildContext context) {
    if (_index == widget.imageList.length) {
      LogUtils.e("打开新的页面");
      //退出
      //Navigator.of(context).pop();
      //替换当前页面
      // Navigator.of(context).pushReplacement(
      //   new MaterialPageRoute(builder: (BuildContext context) {
      //     return TagImagePage();
      //   }),
      // );
      NavigatorUtils.pushPageByFade(
          context: context, targPage: TagImagePage(), isReplace: true);
    }
  }

  PageView buildPageView() {
    return PageView.builder(
      controller: _scrollController,
      //PageView滑动时的回调
      onPageChanged: (index) {
        setState(() {
          _index = index;
        });
      },
      //总个数
      itemCount: widget.imageList.length + 1,
      //每个子Widget
      itemBuilder: (BuildContext context, int index) {
        if (index == widget.imageList.length) {
          //目标页面
          return TagImagePage();
        }
        return Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(widget.imageList[index]),
          ],
        );
      },
    );
  }
}
