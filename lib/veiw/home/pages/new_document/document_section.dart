import 'package:biztalk_panel_admin/veiw/home/pages/new_document/new_document_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewDocumentSection extends StatelessWidget {
  const NewDocumentSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          children: [
            const NewDocumentWidget(
              isTitle: true,
              oneColumn: "نام و نام خانوادگی",
              twoColumn: "نام کاربری",
              threeColumn: "نوع مدرک",
              fourColumn: "عنوان",
              fiveColumn: "فایل مدرک",
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return NewDocumentWidget(
                      onTap: () {},
                      fiveColumn: "دارد",
                      fourColumn: "دانشگاه ازاد اسلامی",
                      threeColumn: "تحصیلی",
                      twoColumn: "sinatari",
                      oneColumn: "سینا جمشیدی طاری",
                      isTitle: false,

                    );
                  },
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                //  pageSection(homeController.resultHomeUsers.value),
              ],
            )
          ],
        ),
      );
}
