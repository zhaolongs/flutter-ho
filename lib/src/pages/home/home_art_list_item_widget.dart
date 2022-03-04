import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ho/src/bean/bean_art.dart';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 2021/1/3.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
///代码清单
class HomeItemArtWidget extends StatefulWidget {
  final ArtBean artBean;

  HomeItemArtWidget({required this.artBean});

  @override
  _HomeItemArtWidgetState createState() => _HomeItemArtWidgetState();
}

class _HomeItemArtWidgetState extends State<HomeItemArtWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //内边距
      padding: EdgeInsets.only(left: 12, top: 12, bottom: 12),
      //外边距
      margin: EdgeInsets.only(top: 4),
      //背景
      decoration: BoxDecoration(
        //线性渐变
        gradient: LinearGradient(
          colors: [
            Colors.orangeAccent.withOpacity(0.5),
            Colors.white,
          ],
          //开始角度左上角
          begin: Alignment.topLeft,
          //结束角度右下角
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        //包裹
        mainAxisSize: MainAxisSize.min,
        //子Widget 左对齐
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //第一行的标题
          Container(
            child: Text(
              "${widget.artBean.artTitle}",
              style: TextStyle(
                //设置文章的粗体
                fontWeight: FontWeight.w600,
                //文字的大小
                fontSize: 18,
              ),
            ),
          ),
          //第二行的左右排开的图文
          Container(
            //水平方向的线性排列
            child: Row(
              children: [
                //权重适配 左侧的文字占用剩余空间
                Expanded(
                  //用户信息与文本简介的竖直方向的线性排列
                  child: Column(
                    //包裹
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //第一部分的用户信息
                      Container(
                        child: Row(
                          children: [
                            Icon(Icons.forward_10),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "早起的年轻人",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 8),
                        child: Text(
                          "${widget.artBean.artInfo}",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //右侧的图片
                buildImageWidget(),
              ],
            ),
          ),
          //第三行的喜欢评论
          Container(
            margin: EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Text("102喜欢"),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: 3,
                  height: 4,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
                Text("17个评论")
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///右侧的图片
  Container buildImageWidget() {
    return Container(
      //外边距为 10
      margin: EdgeInsets.all(10),
      //圆角矩形裁剪
      child: ClipRRect(
        //四个角都裁剪的圆角
        borderRadius: BorderRadius.all(Radius.circular(4)),
        //加载一个本地资源图片
        child: Image.asset(
          "assets/images/app_icon.png",
          width: 90,
          height: 60,
          //图片 填充宽高
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
