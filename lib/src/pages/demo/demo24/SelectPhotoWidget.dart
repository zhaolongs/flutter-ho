import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 6/1/21.
/// 照片选择器
enum ImageType {
  net,
  fill,
  asset,
}

///
class SelectPhotoWidget extends StatefulWidget {
  ///每次点击选择图片后的回调
  final Function(List<String>)? imageSelectAction;

  ///自定义标题
  final Widget? header;

  ///标题下的小捍
  final String? tips;

  ///预显示使用的图片
  final List<String> imageList;

  ///最多可选择的图片数量
  final int maxSelect;

  ///为true 时显示使用网络图片
  final ImageType imageType;

  const SelectPhotoWidget(
      {Key? key,
      this.header,
      this.tips,
      required this.imageList,
      this.imageType = ImageType.asset,
      this.imageSelectAction,
      this.maxSelect = 5})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectPhotoWidgetState();
  }
}

class _SelectPhotoWidgetState extends State<SelectPhotoWidget>
    with WidgetsBindingObserver {
  ///当前是否正在选择图片
  bool _isSelect = false;

  @override
  void initState() {
    super.initState();
    if (widget.imageList != null) {
      //判断一下最大选择图片数据
      if (widget.imageList.length <= widget.maxSelect) {
        _imageList = widget.imageList;
      } else {
        //截取图片
        _imageList = widget.imageList.sublist(0, widget.maxSelect);
      }
    }
    //绑定视图监听
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        break;
      case AppLifecycleState.resumed:
        //从后台切换前台，界面可见
        break;
      case AppLifecycleState.paused:
        // 界面不可见，后台
        break;
      case AppLifecycleState.detached:
        // APP结束时调用
        break;
    }
  }

  @override
  void dispose() {
    //解绑视图监听
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //圆角矩形剪裁
    return ClipRRect(
      //圆角
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        color: Color(0xffFFFFFF),
        //宽度填充
        width: double.infinity,
        //统一内边距
        padding: EdgeInsets.all(10),
        //垂直方向的线性排列
        child: Column(
          //水平方向
          crossAxisAlignment: CrossAxisAlignment.start,
          //包裹
          mainAxisSize: MainAxisSize.min,
          children: [
            //标题
            buildHeaderWidget(),
            //第二行的小提示
            buildTipsWidget(),
            //显示的图片
            buildGridView(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  buildHeaderWidget() {
    return widget.header != null ? widget.header : Container();
  }

  buildTipsWidget() {
    if (widget.tips == null || widget.tips!.length == 0) {
      return Container();
    }
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 16),
      //圆角矩形裁剪
      child: ClipRRect(
        //圆角
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
          color: Color(0xffFFF1F1),
          child: Text(
            "${widget.tips}",
            style: TextStyle(
              color: Color(0xffBD2F2F),
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  List<String> _imageList = [];

  buildGridView() {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        //包裹
        shrinkWrap: true,
        //不可滑动
        physics: NeverScrollableScrollPhysics(),
        //图片个数
        itemCount: getSelectCount(),
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 4,
            //主轴间距
            mainAxisSpacing: 1.0,
            //从轴间距
            crossAxisSpacing: 1.0,
            //子组件宽高长度比例
            childAspectRatio: 1.0),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          if (index == _imageList.length) {
            if (_isSelect) {
              return Center(child: Text("..."));
            }
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  onSelectImageFunction();
                },
              ),
              color: Color(0xFFF1F1F2),
            );
          }
          //显示当前的图片
          String imageUrl = _imageList[index];
          return Container(
            //层叠布局
            child: Stack(
              children: [
                //向左下偏移一点
                Positioned.fill(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      //查看大图
                    },
                    child: Container(
                      padding: EdgeInsets.all(1),
                      child: buildImageWidget(imageUrl),
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      onDeleteImageFunction(index);
                    },
                    child: ClipOval(
                      child: Container(
                        padding: EdgeInsets.all(2),
                        color: Colors.red,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildImageWidget(String image) {
    if (widget.imageType == ImageType.net) {
      return Image.network(
        image,
        fit: BoxFit.fitWidth,
      );
    } else if (widget.imageType == ImageType.asset) {
      return Image.asset(
        image,
        fit: BoxFit.fitWidth,
      );
    }
    return Image.file(
      File(image),
      fit: BoxFit.fitWidth,
    );
  }

  ///最大选择图片数据限制
  getSelectCount() {
    if (_imageList.length >= widget.maxSelect) {
      return widget.maxSelect;
    }
    return _imageList.length + 1;
  }

  //删除照片
  void onDeleteImageFunction(int index) {
    _imageList.removeAt(index);
    setState(() {});
    if (widget.imageSelectAction != null) {
      widget.imageSelectAction!(_imageList);
    }
  }

  void onSelectImageFunction() async {
    _isSelect = true;
    setState(() {});
    String localImageUrl = "assets/images/sp03.png";
    await Future.delayed(Duration(milliseconds: 1000));
    _isSelect = false;
    if (localImageUrl.length > 0) {
      _imageList.add(localImageUrl);
      setState(() {});
      if (widget.imageSelectAction != null) {
        widget.imageSelectAction!(_imageList);
      }
    }
  }
}
