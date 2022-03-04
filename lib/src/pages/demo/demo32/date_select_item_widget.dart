import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DateSelectItemWidget extends StatefulWidget {
  final int start;
  final int end;
  final String unit;
  final int current;
  final Function(int)? selectAction;

  const DateSelectItemWidget(
      {Key? key,
      this.start = 2020,
      this.end = 2120,
      this.unit = "年",
      this.current = -1,
      this.selectAction})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DateSelectItemWidgetState();
  }
}

class _DateSelectItemWidgetState extends State<DateSelectItemWidget> {
  SwiperController _swiperController = new SwiperController();
  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    Future.delayed(Duration.zero, () {
      if (widget.current == -1) {
        if (widget.unit == "年") {
          _swiperController.move(now.year - 2020, animation: true);
        } else if (widget.unit == "月") {
          _swiperController.move(now.month - 1, animation: true);
        } else if (widget.unit == "日") {
          _swiperController.move(now.day - 1, animation: true);
        }
      } else {
        if (_swiperController.hasListeners) {
          _swiperController.move(widget.current - 1, animation: true);
        }
      }
    });
  }

  int _selectIndex = 0;

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("${widget.end}-${widget.start}");
    return Container(
      height: 100,
      width: 60,
      margin: EdgeInsets.all(0),
      child: Swiper(
        viewportFraction: 0.35,
        itemHeight: 22,
        loop: true,
        controller: _swiperController,
        itemWidth: 60,
        itemCount: widget.end - widget.start + 1,
        scrollDirection: Axis.vertical,
        onIndexChanged: (index) {
          this._selectIndex = index;
          if (widget.selectAction != null) {
            //回调
            widget.selectAction!(widget.start + index);
          }
        },
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "${widget.start + index}${widget.unit}",
              style: this._selectIndex == index
                  ? TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w700)
                  : TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(162, 161, 169, 1),
                    ),
            ),
          );
        },
      ),
    );
  }
}
