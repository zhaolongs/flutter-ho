import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';

import 'date_select_day_widget.dart';

class TimerPicker extends StatefulWidget {
  TimerPicker({callback}) {
    this.callback = callback;
  }

  ValueSetter callback = (x) {};

  @override
  _TimerPickerState createState() => _TimerPickerState();
}

class _TimerPickerState extends State<TimerPicker> {
  int startyear = 2020;
  int endyear = 2050;
  int yearindex = 0;
  int monthindex = 0;
  int dayindex = 0;
  int startyear2 = 2020;
  int yearindex2 = 0;
  int monthindex2 = 0;
  int dayindex2 = 0;
  SwiperController yearSwiperController = new SwiperController();
  SwiperController monthSwiperController = new SwiperController();
  SwiperController daySwiperController = new SwiperController();

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      yearSwiperController.move(now.year - 2020, animation: true);
      monthSwiperController.move(now.month - 1, animation: true);
      daySwiperController.move(now.day - 1, animation: true);
    });
  }

  @override
  void dispose() {
    yearSwiperController.dispose();
    monthSwiperController.dispose();
    daySwiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 80,
              height: 312,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('开始日期：',
                          style: TextStyle(
                              color: Color.fromRGBO(21, 21, 21, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  // buildStartContainer(context),
                  DateSelectDayWidget(),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('结束日期：',
                          style: TextStyle(
                              color: Color.fromRGBO(21, 21, 21, 1),
                              fontSize: 13,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  buildEndContainer(context),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          var starttime = DateFormat("yyyy-MM-dd").parse(
              "${yearindex + startyear}-${monthindex + 1}-${dayindex + 1}");
          var endtime = DateFormat("yyyy-MM-dd").parse(
              "${yearindex2 + startyear}-${monthindex2 + 1}-${dayindex2 + 1}");

          if (starttime.isAfter(endtime)) {
            // CustomToast.popTitle(context, "开始日期不能大于结束日期哦！", "知道了","",Color.fromRGBO(250,245,245,1));
            return false;
          }

          widget.callback([
            starttime,
            endtime.add(Duration(days: 1)).add(Duration(seconds: -1))
          ]);
          Navigator.pop(context);
          return false;
        });
  }

  Container buildEndContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      child: Stack(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width - 120,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(242, 242, 244, 0.5)),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Container(
                height: 100,
                width: 60,
                margin: EdgeInsets.all(0),
                child: Swiper(
                  viewportFraction: 0.35,
                  itemHeight: 22,
                  loop: true,
                  itemWidth: 60,
                  itemCount: 31,
                  controller: yearSwiperController,
                  scrollDirection: Axis.vertical,
                  onIndexChanged: (index) {
                    this.yearindex2 = index;
                    var maxday = GetMonthDay(
                        this.yearindex2 + startyear2, this.monthindex2 + 1);
                    if (dayindex2 + 1 > maxday) {
                      dayindex2 = maxday - 1;
                    }
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                        alignment: Alignment.center,
                        child: Text(
                          "${startyear2 + index}年",
                          style: this.yearindex2 == index
                              ? TextStyle(
                                  color: Color.fromRGBO(21, 21, 21, 1),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)
                              : TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(162, 161, 169, 1),
                                ),
                        ));
                  },
                ),
              ),
              Spacer(),
              Container(
                height: 100,
                width: 60,
                margin: EdgeInsets.all(0),
                child: Swiper(
                  viewportFraction: 0.35,
                  itemHeight: 22,
                  loop: true,
                  itemWidth: 60,
                  itemCount: 12,
                  controller: monthSwiperController,
                  scrollDirection: Axis.vertical,
                  onIndexChanged: (index) {
                    this.monthindex2 = index;
                    var maxday = GetMonthDay(
                        this.yearindex2 + startyear2, this.monthindex2 + 1);
                    if (dayindex2 + 1 > maxday) {
                      dayindex2 = maxday - 1;
                    }
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}月",
                        style: this.monthindex2 == index
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
              ),
              Spacer(),
              Container(
                height: 100,
                width: 60,
                margin: EdgeInsets.all(0),
                child: Swiper(
                  viewportFraction: 0.35,
                  itemHeight: 22,
                  loop: true,
                  itemWidth: 60,
                  controller: daySwiperController,
                  itemCount:
                      GetMonthDay(yearindex2 + startyear2, monthindex2 + 1),
                  scrollDirection: Axis.vertical,
                  onIndexChanged: (index) {
                    this.dayindex2 = index;
                    setState(() {});
                  },
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}日",
                        style: this.dayindex2 == index
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
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildStartContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 120,
      child: Stack(
        children: [
          Container(
            height: 100,
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width - 120,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromRGBO(242, 242, 244, 0.9)),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 20,
              ),

              //buildStartYearContainer(),
              Spacer(),
              // buildStartMonthContainer(),

              Spacer(),
              buildStartDayContainer()
            ],
          )
        ],
      ),
    );
  }

  Container buildStartDayContainer() {
    return Container(
      height: 100,
      width: 60,
      margin: EdgeInsets.all(0),
      child: Swiper(
        viewportFraction: 0.35,
        itemHeight: 22,
        loop: true,
        itemWidth: 60,
        controller: daySwiperController,
        itemCount: GetMonthDay(yearindex + startyear, monthindex + 1),
        scrollDirection: Axis.vertical,
        onIndexChanged: (index) {
          this.dayindex = index;

          setState(() {});
        },
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "${index + 1}日",
              style: this.dayindex == index
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

  Container buildStartMonthContainer() {
    return Container(
      height: 100,
      width: 60,
      margin: EdgeInsets.all(0),
      child: Swiper(
        viewportFraction: 0.35,
        itemHeight: 22,
        loop: true,
        itemWidth: 60,
        controller: monthSwiperController,
        itemCount: 12,
        scrollDirection: Axis.vertical,
        onIndexChanged: (index) {
          this.monthindex = index;
          print(this.dayindex);
          var maxday =
              GetMonthDay(this.yearindex + startyear, this.monthindex + 1);
          print(maxday);
          if (dayindex + 1 > maxday) {
            dayindex = maxday - 1;
          }
          setState(() {});
        },
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "${index + 1}月",
              style: this.monthindex == index
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

  Container buildStartYearContainer() {
    return Container(
      height: 100,
      width: 60,
      margin: EdgeInsets.all(0),
      child: Swiper(
        viewportFraction: 0.35,
        itemHeight: 22,
        loop: true,
        controller: yearSwiperController,
        itemWidth: 60,
        itemCount: 31,
        scrollDirection: Axis.vertical,
        onIndexChanged: (index) {
          this.yearindex = index;
          var maxday =
              GetMonthDay(this.yearindex + startyear, this.monthindex + 1);
          if (dayindex + 1 > maxday) {
            dayindex = maxday - 1;
          }
          setState(() {});
        },
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "${startyear + index}年",
              style: this.yearindex == index
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

  GetMonthDay(year, month) {
    var a = {
      1: 31,
      2: 28,
      3: 31,
      4: 30,
      5: 31,
      6: 30,
      7: 31,
      8: 31,
      9: 30,
      10: 31,
      11: 30,
      12: 31
    };
    if (month != 2) {
      return a[month];
    } else {
      if (year % 400 == 0) {
        return 29;
      } else if (year % 4 == 0 && year % 100 != 0) {
        return 29;
      } else {
        return 28;
      }
    }
  }
}
