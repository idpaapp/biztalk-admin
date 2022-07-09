import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/insert_user/insert_user_dialog.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/manager_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MasterPage extends StatelessWidget {
  MasterPage({Key? key}) : super(key: key);
  final HomeController _homeController = Get.put(HomeController());
  late List<MasterModel> masterList = [
    MasterModel(
        title: "لیست کاربران",
        iconData: Icons.account_box_outlined,
        count: "1",
        key: "USERS"),
    MasterModel(
        title: "حساب های بانکی تایید شده",
        iconData: Icons.wallet,
        count: "0",
        key: "BANK"),
    MasterModel(
        title: "درخواست تسویه حساب",
        iconData: Icons.wallet,
        count: "0",
        key: "WITHRAW"),
    MasterModel(
        title: "درخواست جلسه",
        iconData: Icons.list_rounded,
        count: "0",
        key: "REQUEST"),
    MasterModel(
        title: "جلسه( نیاز به بررسی)",
        iconData: Icons.list_rounded,
        count: "0",
        key: "SESSION"),
    MasterModel(
        title: "گزارش تخلف",
        iconData: Icons.list_alt,
        count: "2",
        key: "REPORT"),
    MasterModel(
        title: "رسانه جدید وارد شده",
        iconData: Icons.perm_media_rounded,
        count: "2",
        key: "MEDIA"),
    MasterModel(
        title: "کد های تخفیف",
        iconData: Icons.card_giftcard_sharp,
        count: "2",
        key: "OFF_COD"),
    MasterModel(
        title: "کاربران بررسی نشده",
        iconData: Icons.person_outline,
        count: "2",
        key: "USER_NOT"),
    MasterModel(
        title: "مدیریت صفحه اصلی",
        iconData: Icons.card_giftcard_outlined,
        count: "2",
        key: "MANAGER_PAGE"),
    MasterModel(
        title: "افزودن کاربر جدید",
        iconData: Icons.person_add_alt,
        count: "2",
        key: "INSERT_USER"),
  ];

  @override
  Widget build(BuildContext context) => Container(
        width: Get.width,
        height: Get.height,
        color: AppColors.masterColor,
        child: Align(
          alignment: Alignment.topRight,
          
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                SizedBox(height: 32,),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: masterList.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = masterList[index];
                      return Obx(() => ItemMasterPage(
                            title: data.title,
                            iconData: data.iconData,
                            count: data.count,
                            selected: _homeController.tab.value == index
                                ? AppColors.masterColorSelected
                                : AppColors.masterColor,
                            onTap: () {
                              _homeController.tab.value = index;
                              if (data.key == "MANAGER_PAGE") {
                                Get.to(() => ManagerPage());
                                return;
                              }
                              if (data.key == "INSERT_USER") {
                                insertUser(context, "افزودن کاربر جدید");
                                return;
                              }
                            },
                          ));
                    }),
              ],
            ),
          ),
        ),
      );
}

class ItemMasterPage extends StatelessWidget {
  final String? title;
  final IconData? iconData;
  final Color? selected;
  final String? count;
  final onTap;

  const ItemMasterPage(
      {Key? key,
      this.iconData,
      this.title,
      this.selected,
      this.count,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          color: selected,
          child: Row(
            children: [
              Expanded(child: Icon(iconData, color: Colors.white, size: 20)),
            
              Expanded(flex: 5,child: CustomText(
                title: title,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),),
            
              count == null
                  ? SizedBox(
                      width: 0,
                    )
                  : Expanded(
                    child: CustomText(
                        title: "($count)",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                  ),
            ],
          ),
        ),
      );
}

class MasterModel {
  final String? title;
  final IconData? iconData;
  final String? count;
  final String? key;

  MasterModel({
    this.title,
    this.iconData,
    this.count,
    this.key,
  });
}
