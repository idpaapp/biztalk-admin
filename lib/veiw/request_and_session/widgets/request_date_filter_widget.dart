import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/textfield_container_widget.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/title_filter_section.dart';
import 'package:flutter/material.dart';

class RequestDateFilterWidget extends StatelessWidget {
  final String? title;
  RequestDateFilterWidget({Key? key,this.title}) : super(key: key);


  final TextEditingController _start = TextEditingController();
  final TextEditingController _end = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: AppColors.disabledGrey),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
          TitleFilterSection(
            title: title,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                const Expanded(
                    child: Center(child: CustomText(title: "از", color: AppColors.darkerGrey))),
                Expanded(
                  flex: 3,
                  child: Align(alignment: Alignment.centerRight,child: TextfieldContainerWidget(textEditingController: _start)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                const Expanded(
                    child: Center(child: CustomText(title: "تا", color: AppColors.darkerGrey))),
                Expanded(
                  flex: 3,
                  child: Align(alignment: Alignment.centerRight,child: TextfieldContainerWidget(textEditingController: _end)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,)
        ]),
      );
}
