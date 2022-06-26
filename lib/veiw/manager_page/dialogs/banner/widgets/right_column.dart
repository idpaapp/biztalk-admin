import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/dialogs/banner/widgets/image_selected_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class RightColumnBanner extends StatelessWidget {
  final onSelectedImage;
  final ManagerPageController _managerPageController = Get.find();

  RightColumnBanner({Key? key, this.onSelectedImage}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: CustomText(
              title: "تصویر برند",
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.black,
            ),
          ),
          Obx(
            () => AspectRatio(
              aspectRatio: 1 / 0.5,
              child: ImageSelectedWidget(
                title: "بارگذاری",
                iconData: Icons.upload_rounded,
                imgPath: _managerPageController.selectedImagedPath.value,
                onTap: () {
                  _managerPageController.getImage(ImageSource.gallery);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Expanded(
                    flex: 7,
                    child: ButtonText(
                      onPressed: () {
                        _managerPageController.getImage(ImageSource.gallery);
                      },
                      text: "بارگذاری",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 35,
                      borderRadios: 5,
                      bgColor: AppColors.green,
                      textColor: Colors.white,
                    )),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(child: Icon(Icons.delete,color: Colors.white,)),
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8,)
        ],
      );

}
