import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/delete_accept_widget.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_bottomsheet.dart';
import 'package:biztalk_panel_admin/veiw/documents/document_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class LeftSectionWidget extends StatelessWidget {
  final onDelete;
  final onConfeirm;
  List<Attachment>? attachment;

  LeftSectionWidget({Key? key, this.onDelete, this.onConfeirm, this.attachment})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: CustomText(
                  color: AppColors.lighterBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  title: "مدارک",
                ),
              ),
              DeleteAcceptWidget(
                onConfirm: onConfeirm,
                onDelete: onDelete,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 90,
            width: Get.width,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: AppColors.veryLightBlue),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: attachment!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    CustomBottomSheet.myBottomSheet(
                      title: "pdf",
                      widget: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: const CustomText(
                              title: "نمایش",
                            ),
                            onTap: () async {
                              await launch(GlobalInfo.serverAddress +
                                  "/" +
                                  attachment![index].fileUrl!);
                            },
                          ),
                          ListTile(
                            onTap: () {
                              // _jobController.listPdfJobId.remove(
                              //     _jobController.listPdfJobId[index]);
                              // _jobController.listPdfJobUrl.remove(
                              //     _jobController.listPdfJobUrl[index]);
                              //
                              // Get.back();
                            },
                            title: const CustomText(
                              title: "حذف",
                              color: AppColors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    height: 70,
                    width: 90,
                    decoration: DottedDecoration(
                      color: AppColors.darkGrey,
                      shape: Shape.box,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/icons/pdf.svg"),
                        CustomText(
                          title: attachment![index].id,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );
}
