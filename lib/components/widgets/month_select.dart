import 'package:biztalk_panel_admin/components/utils/month_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MonthSelect extends StatefulWidget {
  final TextStyle? monthTextStyle;
  final TextStyle? yearTextStyle;
  final List<String>? customMonthesName;
  final Jalali jalali;
  final Function(Jalali) onMonthChange;

  const MonthSelect({
    Key? key,
    required this.jalali,
    required this.onMonthChange,
    this.monthTextStyle,
    this.yearTextStyle,
    this.customMonthesName,
  });

  @override
  _MonthSelectState createState() => _MonthSelectState(
        jalali: jalali,
      );
}

class _MonthSelectState extends State<MonthSelect> {
  Jalali? jalali;

  _MonthSelectState({
    this.jalali,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(onTap: (){
          setState(() {
            jalali = jalali!.addMonths(-1);
            widget.onMonthChange(jalali!);
          });

        },child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("ماه قبل",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
        ),),

        const Spacer(),
        Text(
          (widget.customMonthesName != null &&
                  widget.customMonthesName!.length == 11)
              ? widget.customMonthesName![jalali!.month - 1]
              : MonthUtil.getMonthName(jalali!.month),
          style: widget.monthTextStyle,
        ),
        const SizedBox(width: 8),
        Text(
          jalali!.year.toString(),
          style: widget.yearTextStyle,
        ),
        const Spacer(),
        InkWell(onTap: (){
          setState(() {
            jalali = jalali!.addMonths(1);
            widget.onMonthChange(jalali!);
          });
        },child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("ماه بعد",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500),),
        ),)
      ],
    );
  }
}
