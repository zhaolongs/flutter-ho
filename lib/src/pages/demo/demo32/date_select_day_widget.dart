import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'date_select_item_widget.dart';

class DateSelectDayWidget extends StatefulWidget {
  final int start;
  final int end;
  final String unit;

  const DateSelectDayWidget(
      {Key? key, this.start = 2020, this.end = 2120, this.unit = ""})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DateSelectDayWidgetState();
  }
}

class _DateSelectDayWidgetState extends State<DateSelectDayWidget> {
  StreamController<int> _dayStreamController = StreamController.broadcast();

  int _currentYear = 0;
  int _currentMonth = 0;
  int _currentDay = 0;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    _currentYear = now.year;
    _currentMonth = now.month - 1;
    _currentDay = now.day - 1;
  }

  @override
  void dispose() {
    _dayStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              DateSelectItemWidget(
                unit: "年",
                start: 2020,
                end: 2024,
                selectAction: (int year) {
                  _currentYear = year;
                  _dayStreamController.add(0);
                },
              ),
              //buildStartYearContainer(),
              Spacer(),
              // buildStartMonthContainer(),
              DateSelectItemWidget(
                unit: "月",
                start: 1,
                end: 12,
                selectAction: (int month) {
                  _currentMonth = month;
                  _dayStreamController.add(0);
                },
              ),
              Spacer(),
              StreamBuilder<int>(
                  stream: _dayStreamController.stream,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    int endDay = 31;
                    if (_currentMonth == 2) {
                      //闰年
                      if (_currentYear % 400 == 0 ||
                          _currentYear % 4 == 0 && _currentYear % 100 != 0) {
                        endDay = 29;
                      } else {
                        endDay = 28;
                      }
                    } else {
                      if (_currentMonth % 2 == 0) {
                        endDay = 31;
                      } else {
                        endDay = 30;
                      }
                    }

                    return DateSelectItemWidget(
                      unit: "日",
                      start: 1,
                      key: UniqueKey(),
                      end: endDay,
                      current: _currentDay,
                      selectAction: (int day) {
                        _currentDay = day;
                      },
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}
