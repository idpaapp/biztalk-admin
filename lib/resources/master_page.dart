import 'package:badges/badges.dart';
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
        count: _homeController.resultFetchHome.value.data!.userCount.toString(),
        key: "USERS"),
    MasterModel(
        title: "حساب های بانکی تایید شده",
        iconData: Icons.wallet,
        count: _homeController.resultFetchHome.value.data!.notVerifiedAccount
            .toString(),
        key: "BANK"),
    MasterModel(
        title: "درخواست تسویه حساب",
        iconData: Icons.wallet,
        count: _homeController.resultFetchHome.value.data!.checkOutCount
            .toString(),
        key: "WITHRAW"),
    MasterModel(
        title: "درخواست جلسه",
        iconData: Icons.list_rounded,
        count:
            _homeController.resultFetchHome.value.data!.requestCount.toString(),
        key: "REQUEST"),
    MasterModel(
        title: "جلسه( نیاز به بررسی)",
        iconData: Icons.list_rounded,
        count:
            _homeController.resultFetchHome.value.data!.sessionCount.toString(),
        key: "SESSION"),
    MasterModel(
        title: "گزارش تخلف",
        iconData: Icons.list_alt,
        count:
            _homeController.resultFetchHome.value.data!.reportCount.toString(),
        key: "REPORT"),
    MasterModel(
        title: "رسانه جدید وارد شده",
        iconData: Icons.perm_media_rounded,
        count: _homeController.resultFetchHome.value.data!.tvCount.toString(),
        key: "MEDIA"),
    MasterModel(
        title: "کد های تخفیف",
        iconData: Icons.card_giftcard_sharp,
        count:
            _homeController.resultFetchHome.value.data!.userChecking.toString(),
        key: "OFF_COD"),
    MasterModel(
        title: "کاربران بررسی نشده",
        iconData: Icons.person_outline,
        count:
            _homeController.resultFetchHome.value.data!.userChecking.toString(),
        key: "USER_NOT"),
    MasterModel(
        title: "مدیریت صفحه اصلی",
        iconData: Icons.card_giftcard_outlined,
        count: "0",
        key: "MANAGER_PAGE"),
    MasterModel(
        title: "افزودن کاربر جدید",
        iconData: Icons.person_add_alt,
        count: "0",
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
                SizedBox(
                  height: 32,
                ),
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
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              color: selected,
              child: Row(
                children: [
                  Expanded(
                      child: Icon(iconData, color: Colors.white, size: 20)),
                  Expanded(
                    flex: 7,
                    child: CustomText(
                      title: title,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            count == null || count == "0"
                ? SizedBox(
                    width: 0,
                  )
                : Container(margin: EdgeInsets.symmetric(horizontal: 12),height: 25,width: 25,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),child: Center(
                  child: CustomText(
                  title: count!,
                  fontSize: 14,
                  color: AppColors.masterColor),
                ),)
          ],
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
