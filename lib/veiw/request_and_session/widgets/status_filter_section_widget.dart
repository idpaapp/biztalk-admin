import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/title_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusFilterSectionWidget extends StatelessWidget {
  StatusFilterSectionWidget({Key? key}) : super(key: key);

  final RequestSessionController _requestSessionController =
      Get.put(RequestSessionController());
  final List status = [
    "درخواست مشاوره",
    "درخواست تایید شده",
    "زمان جلسه تعیین شده",
    "جلسه برگزار شده"
  ];

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
        child: Column(children: [
          const TitleFilterSection(
            title: "وضعیت",
          ),
          ListView.builder(
              itemCount: status.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      if(_requestSessionController.selectedStatus.contains(index)){
                        _requestSessionController.selectedStatus.remove(index);
                      }else{
                        _requestSessionController.selectedStatus.add(index);
                      }
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: _requestSessionController
                                          .selectedStatus.contains(index)
                                  ? AppColors.blueIndigo
                                  : Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border.all(color: AppColors.darkerGrey),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          CustomText(
                            title:
                                status[index],
                            color: AppColors.darkerGrey,
                            fontSize: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })
        ]),
      );
}
