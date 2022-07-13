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
  late List<FilterModel> listFilter = [
    FilterModel(title: "درخواست مشاوره", key: "draft"),
    FilterModel(title: "درخواست تایید شده", key: "confirmed"),
    FilterModel(title: "زمان جلسه تعیین شده", key: "reserved"),
    FilterModel(title: "جلسه برگزار شده", key: "completed"),
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
              itemCount: listFilter.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      if (_requestSessionController.selectedStatus
                          .contains(listFilter[index].key)) {
                        _requestSessionController.selectedStatus.remove(listFilter[index].key);
                      } else {
                        _requestSessionController.selectedStatus.add(listFilter[index].key);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: _requestSessionController.selectedStatus
                                      .contains(listFilter[index].key)
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
                            title: listFilter[index].title,
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

class FilterModel {
  final String? title;
  final String? key;

  FilterModel({this.title, this.key});
}
