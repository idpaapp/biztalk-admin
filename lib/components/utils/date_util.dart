import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateUtil {
  static final _shortWeekName = [
    "ش",
    "ی",
    "د",
    "س",
    "چ",
    "پ",
    "ج",
  ];

  static final _fullWeekNames = [
    "شنبه",
    "یکشنبه",
    "دوشنبه",
    "سه شنبه",
    "چهارشنبه",
    "پنجشنبه",
    "جمعه",
  ];

  static int _startWeekDayOfMonth(Jalali jalali) {
    return jalali.withDay(1).weekDay;
  }

  static int _monthLength(Jalali jalali) {
    return jalali.monthLength;
  }

  static String formatDate(Jalali jalali, String format) {
    var result = format;
    if (result == "") {
      result = "yyyy/mm/dd";
    }

    var d = jalali.formatter.d;
    var dd = jalali.formatter.dd;
    var m = jalali.formatter.m;
    var mm = jalali.formatter.mm;
    var yy = jalali.formatter.yy;
    var yyyy = jalali.formatter.yyyy;

    result = result.replaceAll(RegExp('yyyy'), yyyy);
    result = result.replaceAll(RegExp('yy'), yy);
    result = result.replaceAll(RegExp('mm'), mm);
    result = result.replaceAll(RegExp('m'), m);
    result = result.replaceAll(RegExp('dd'), dd);
    result = result.replaceAll(RegExp('d'), d);

    return result;
  }

  static String formatGregorianDate(Gregorian gregorian, String format) {
    var result = format;
    if (result == "") {
      result = "yyyy/mm/dd";
    }

    var d = gregorian.formatter.d;
    var dd = gregorian.formatter.dd;
    var m = gregorian.formatter.m;
    var mm = gregorian.formatter.mm;
    var yy = gregorian.formatter.yy;
    var yyyy = gregorian.formatter.yyyy;

    result = result.replaceAll(RegExp('yyyy'), yyyy);
    result = result.replaceAll(RegExp('yy'), yy);
    result = result.replaceAll(RegExp('mm'), mm);
    result = result.replaceAll(RegExp('m'), m);
    result = result.replaceAll(RegExp('dd'), dd);
    result = result.replaceAll(RegExp('d'), d);

    return result;
  }

  static List<Widget> daysWidget({
    Jalali? jalali,
    Function(Jalali)? onDateSelect,
    TextStyle? activeDateTextStyle,
    TextStyle? deactiveDateTextStyle,
    List<int>? deactiveWeekList,
    required Function(Jalali) onDeactiveDateSelect,
    List<int>? deactiveDayList,
    int? selectedDay,
    double datesBorderRadius = 32.0,
    Color deactiveSelectedDateBackColor = Colors.red,
    Color activeSelectedDateBackColor = Colors.blue,
    Color deactiveSelectedDateTextColor = Colors.black,
    Color activeSelectedDateTextColor = Colors.white,
  }) {
    final startDay = _startWeekDayOfMonth(jalali!) - 1;

    return List.generate(_monthLength(jalali) + startDay, (index) {
      if (index < startDay) {
        return const TextButton(
          child: Text('-'),
          onPressed: null,
        );
      }

      var activeStyle =
          activeDateTextStyle ?? const TextStyle(fontWeight: FontWeight.w400);
      var deactiveStyle = deactiveDateTextStyle ??
          const TextStyle(color: Colors.red, fontWeight: FontWeight.w400);
      var _datesBorderRadius = datesBorderRadius;
      var _deactiveSelectedDateBackColor = deactiveSelectedDateBackColor;
      var _activeSelectedDateBackColor = activeSelectedDateBackColor;
      var _deactiveSelectedDateTextColor = deactiveSelectedDateTextColor;
      var _activeSelectedDateTextColor = activeSelectedDateTextColor;
      var day = index - startDay + 1;

      // HACK: overrides the sent color in style if date is selected
      if (selectedDay == day) {
        activeStyle = activeStyle.copyWith(color: _activeSelectedDateTextColor);
        deactiveStyle =
            deactiveStyle.copyWith(color: _deactiveSelectedDateTextColor);
      }

      // this checks whethter it is in deactive list or not
      if (deactiveWeekList != null &&
          deactiveWeekList.contains(jalali.withDay(day).weekDay)) {
        return Container(
          decoration: BoxDecoration(
              color: selectedDay == day
                  ? _deactiveSelectedDateBackColor
                  : Colors.transparent,
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              selectedDay = day;
              onDeactiveDateSelect(jalali.withDay(day));
            },
            child: Center(
              child: Text(
                '$day',
                style: deactiveStyle,
              ),
            ),
          ),
        );
      }

      // sets deactive days
      if (deactiveDayList != null && deactiveDayList.contains(day)) {
        return Container(
          decoration: BoxDecoration(
              color: selectedDay == day
                  ? _deactiveSelectedDateBackColor
                  : Colors.transparent,
              shape: BoxShape.circle),
          child: InkWell(
            onTap: () {
              onDateSelect!(jalali.withDay(index - startDay + 1));
            },
            child: Center(
              child: Text(
                '$day',
                style: deactiveStyle,
              ),
            ),
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
            color: selectedDay == day
                ? _activeSelectedDateBackColor
                : Colors.transparent,
            shape: BoxShape.circle),
        child: InkWell(
          onTap: () {
            selectedDay = day;
            onDeactiveDateSelect(
              jalali.withDay(day),
            );
          },
          child: Center(
            child:  Text(
              '$day',
              style: activeStyle,
            ),
          ),
        ),
      );
    });
  }

  static List<Widget> headerWidget(
    bool useFullWeekName,
    TextStyle weekTextStyle,
  ) {
    final _header = (useFullWeekName)
        ? _fullWeekNames
        : _shortWeekName;
    final _headerWidget = _header.map((x) {
      return Center(
        child: Text(
          x,
          style: weekTextStyle,
        ),
      );

      return Center(
        child: Text(
          x,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      );
    }).toList();

    return _headerWidget;
  }
}
