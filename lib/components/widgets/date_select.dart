import 'package:biztalk_panel_admin/components/utils/date_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class DateSelect extends StatefulWidget {
  final Jalali jalali;
  final bool? useFullWeekName;
  final TextStyle? weekTextStyle;
  final Function(String, String) onDateSelect;
  final TextStyle? activeDateTextStyle;
  final List<int>? deactiveWeekList;
  final Function(String, String)? onDeactiveDateSelect;
  final TextStyle? deactiveDateTextStyle;
  final List<int>? deactiveDayList;
  final Color? activeSelectedDateBackColor;
  final Color? deactiveSelectedDateBackColor;
  final Color? activeSelectedDateTextColor;
  final Color? deactiveSelectedDateTextColor;
  final double? datesBorderRadius;
  final String? shamsiDateStringFormat;
  final String? gregorianDateStringFormat;

  const DateSelect({
    Key? key,
    required this.jalali,
    required this.onDateSelect,
    this.onDeactiveDateSelect,
    this.useFullWeekName = false,
    this.weekTextStyle,
    this.activeDateTextStyle,
    this.deactiveWeekList,
    this.deactiveDateTextStyle,
    this.deactiveDayList,
    this.activeSelectedDateBackColor,
    this.activeSelectedDateTextColor,
    this.datesBorderRadius,
    this.deactiveSelectedDateBackColor,
    this.deactiveSelectedDateTextColor,
    this.shamsiDateStringFormat,
    this.gregorianDateStringFormat,
  }) : super(key: key);

  @override
  _DateSelectState createState() => _DateSelectState();
}

class _DateSelectState extends State<DateSelect> {
  int selectedDate = Jalali.now().day;



  @override
  Widget build(BuildContext context) {
    var gridViewChild = <Widget>[];
    gridViewChild.addAll(
        DateUtil.headerWidget(widget.useFullWeekName!, widget.weekTextStyle!));
    gridViewChild.addAll(
      DateUtil.daysWidget(
          jalali: widget.jalali,
          activeDateTextStyle: widget.activeDateTextStyle!,
          deactiveWeekList: widget.deactiveWeekList,
          deactiveDateTextStyle: widget.deactiveDateTextStyle!,
          deactiveDayList: widget.deactiveDayList,
          selectedDay: selectedDate,
          activeSelectedDateBackColor: widget.activeSelectedDateBackColor!,
          activeSelectedDateTextColor: widget.deactiveSelectedDateBackColor!,
          datesBorderRadius: widget.datesBorderRadius!,
          deactiveSelectedDateBackColor: widget.activeSelectedDateBackColor!,
          deactiveSelectedDateTextColor: widget.deactiveSelectedDateBackColor!,
          onDateSelect: (Jalali jalali) {
            setState(() {
              selectedDate = jalali.day;
            });
            final resultShamsi =
                DateUtil.formatDate(jalali, widget.shamsiDateStringFormat!);

            final resultGregorian = DateUtil.formatGregorianDate(
                jalali.toGregorian(), widget.gregorianDateStringFormat!);
            widget.onDateSelect(resultShamsi, resultGregorian);
          },
          onDeactiveDateSelect: (Jalali jalali) {
            setState(() {
              selectedDate = jalali.day;
            });
            final resultShamsi =
                DateUtil.formatDate(jalali, widget.shamsiDateStringFormat!);
            final resultGregorian = DateUtil.formatGregorianDate(
                jalali.toGregorian(), widget.gregorianDateStringFormat!);

             widget.onDateSelect(resultShamsi,resultGregorian);
          }),
    );

    return Expanded(
      child: GridView.count(
        childAspectRatio: (Get.width*0.02) /(Get.height*0.013),
        crossAxisCount: 7,
        children: gridViewChild.toList(),
      ),
    );
  }
}
