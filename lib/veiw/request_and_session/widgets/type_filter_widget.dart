import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/title_filter_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeFilterWidget extends StatelessWidget {

   TypeFilterWidget({Key? key,}) : super(key: key);
  final RequestSessionController _requestSessionController = Get.put(RequestSessionController());

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
            title: "نوع",
          ),
          ListView.builder(
              itemCount: 2,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Obx(()=>InkWell(
                  onTap: (){
                    _requestSessionController.typeSelectedFilter.value =index;

                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: _requestSessionController.typeSelectedFilter.value == index
                                ? AppColors.blueIndigo
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.darkerGrey),
                          ),
                        ),
                        const SizedBox(width: 15,),
                        CustomText(
                          title:index == 0? "درخواست مشاوره" :"جلسه مشاوره",
                          color: AppColors.darkerGrey,
                          fontSize: 14,
                        )
                      ],
                    ),
                  ),
                ),);
              })
        ]),
      );
}
