import 'dart:math';

/// 创建人： Created by zhaolong
/// 创建时间：Created by  on 3/26/21.
///
/// 可关注公众号：我的大前端生涯   获取最新技术分享
/// 可关注网易云课堂：https://study.163.com/instructor/1021406098.htm
/// 可关注博客：https://blog.csdn.net/zl18603543572
///
/// 代码清单
/// 角度处理工具类
class RadianUtils {
  ///弧度是角的度量单位 单位缩写是rad  360°角=2π弧度
  ///在Flutter中，π 使用 [pi] 来表示 1弧度约为57.3°，1°为π/180弧度
  ///弧度换算成角度 参数[radian]为弧度
  static double radianToAngle(double radian) {
    return radian * 180 / (pi);
  }

  ///角度换算成弧度 参数[angle]为角度
  static double angleToRadian(double angle) {
    return angle * pi / 180;
  }

  ///获取象限
  static int getQuadrant(double x, double y) {
    if (x >= 0) {
      return y >= 0 ? 4 : 1;
    }
    return y >= 0 ? 3 : 2;
  }

  ///两点之间的距离
  static double distanceForTwoPoint(
      double x1, double y1, double x2, double y2) {
    double distanceX = x1 - x2;
    double distanceY = y1 - y2;
    return sqrt(pow(distanceX, 2) + pow(distanceY, 2));
  }

  ///获取点相对中心点的角度
  ///
  ///@param centerX 基准点x
  ///@param centerY 基准的y
  ///@param x       当前点x
  ///@param y       当前点y
  ///@return

  static double getPointAngle(
      double centerX, double centerY, double x, double y) {
    double distance = distanceForTwoPoint(centerX, centerY, x, y);
//弧度
    double radian = 0;
    if (x > centerX && y < centerY) {
      radian = pi * 2 - asin((centerY - y) / distance);
    } else if (x < centerX && y < centerY) {
      radian = pi + asin((centerY - y) / distance);
    } else if (x < centerX && y > centerY) {
      radian = pi - asin((y - centerY) / distance);
    } else if (x > centerX && y > centerY) {
      radian = asin((y - centerY) / distance);
    }
//转角度
    return radianToAngle(radian);
  }

  ///
  ///根据手势滑动速度，计算角速度
  ///@param velocityX  up时x方向的线速度
  ///@param velocityY  up时y方向的线速度
  ///@param levelAngle 触点到中心点的线与水平线正方向的夹角
  ///@param quadrant   象限
  ///@param distance   触点到中心店的距离
  static double calculateAngleFromVelocity(double velocityX, double velocityY,
      double levelAngle, int quadrant, double distance) {
//转换成与水平线的夹角
    if (levelAngle > 270) {
      levelAngle = 360 - levelAngle;
    } else if (levelAngle > 90 && levelAngle < 180) {
      levelAngle = 180 - levelAngle;
    } else {
      levelAngle = levelAngle % 90;
    }
//获得线速度与水平夹角,即矢量速度与水平方向的夹角
    double lineSpeed = (sqrt(pow(velocityX, 2) + pow(velocityY, 2)));
    double vectorAngle = radianToAngle(asin((velocityY).abs() / lineSpeed));
//不需要惯性旋转
    if (vectorAngle == levelAngle) {
      return 0;
    }
//圆切速度与线速度的夹角
    double circleLineAngle;
    bool isCW; //是否顺时针
    if (quadrant == 4) {
      if (velocityX > 0 && velocityY < 0) {
        isCW = false;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle - levelAngle
            : 90 - vectorAngle - levelAngle;
      } else if (velocityX > 0 && velocityY > 0) {
        isCW = vectorAngle > levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else if (velocityX < 0 && velocityY < 0) {
        isCW = vectorAngle < levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else {
        isCW = true;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle + levelAngle - 90
            : 90 - vectorAngle - levelAngle;
      }
    } else if (quadrant == 3) {
      if (velocityX > 0 && velocityY < 0) {
        isCW = vectorAngle > levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else if (velocityX > 0 && velocityY > 0) {
        isCW = false;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle - levelAngle
            : vectorAngle + levelAngle;
      } else if (velocityX < 0 && velocityY > 0) {
        isCW = vectorAngle < levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else {
        isCW = true;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle + levelAngle - 90
            : 90 - vectorAngle - levelAngle;
      }
    } else if (quadrant == 2) {
      if (velocityX > 0 && velocityY < 0) {
        isCW = true;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle + levelAngle - 90
            : 90 - vectorAngle - levelAngle;
      } else if (velocityX > 0 && velocityY > 0) {
        isCW = vectorAngle < levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else if (velocityX < 0 && velocityY > 0) {
        isCW = false;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle - levelAngle
            : 90 - vectorAngle - levelAngle;
      } else {
        isCW = vectorAngle > levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      }
    } else {
      if (velocityX > 0 && velocityY < 0) {
        isCW = vectorAngle < levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else if (velocityX > 0 && velocityY > 0) {
        isCW = true;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle + levelAngle - 90
            : 90 - vectorAngle - levelAngle;
      } else if (velocityX < 0 && velocityY > 0) {
        isCW = vectorAngle > levelAngle;
        circleLineAngle = vectorAngle > levelAngle
            ? 90 - vectorAngle + levelAngle
            : 90 + vectorAngle - levelAngle;
      } else {
        isCW = false;
        circleLineAngle = vectorAngle > levelAngle
            ? vectorAngle - levelAngle
            : vectorAngle + levelAngle;
      }
    }

//计算圆切速度,通过弧度计算，角度要先转换为弧度
    double circleSpeed = (lineSpeed * cos(circleLineAngle)).abs();
//角速度w与线速度v的关系:  wr = v
    return (circleSpeed / distance * (isCW ? 1 : -1));
  }
}
