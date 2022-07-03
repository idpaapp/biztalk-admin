import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/text_fiels_custom_widget.dart';
import 'package:biztalk_panel_admin/veiw/manager_page/widgets/single_mentor_roe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final TextEditingController _titleList = TextEditingController();
final TextEditingController _link = TextEditingController();
final TextEditingController _search = TextEditingController();
final HomeController _homeController = Get.put(HomeController());
Future<void> selectUserDialog(BuildContext context,
    {String? image,

      String? fullName,
      String bannerType="link",
      String? id,
      String? phone,
      String? userName,
      String? bannerGroup,
      onConfirmImage}) async {
  _homeController.fetchUsers(1,type: "mentor");

  _link.text="";
  _titleList.text="";
  // _userName.text = userName!;
  // _fullName.text = fullName!;
  // _phone.text = phone!;


  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
            size: 3,
            title: "ویرایش / افزودن",
            ),
        content: Container(
            height:Get.height * 0.8,
            width: Get.width * 0.6,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.02, vertical: Get.height * 0.005),

                child: SingleChildScrollView(
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userListSection(),
                    ],
                  ),
                )),
          ),

        actions: <Widget>[
          Container(
            width: double.infinity,
            height: 1,
            color: AppColors.dividerDark,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: ()  {
                    _homeController.selectedMentorFinaly.clear();
                    _homeController.selectedMentorFinaly.addAll(_homeController.selectedMentor);
                    _homeController.selectedMentor.clear();
                    Get.back();

                  },
                  text: "ذخیره",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {

                    _homeController.selectedMentor.clear();
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                  bgColor: AppColors.disabledGrey,
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}

Widget userListSection() => Container(
  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5), color: Colors.white),
  child: Column(
    children: [
      TextFieldsCustomWidget(
        searchController: _search,
        onTap: () {
          _homeController.fetchUsers(1, mobile: _search.text);
        },
      ),
      SizedBox(
        height: Get.height * 0.02,
      ),
      const SingleMentorRow(
        isTitle: true,
        image: "",
        userName: "نام کاربری",
        fullName:  "نام و نام خانوادگی",
        phoneNumber: "شماره تلفن",
      ),
      Obx(() {
        if (_homeController.failureMessage.value != "") {
          return SizedBox(
            height: 100,
            width: Get.width,
            child: Center(
                child: CustomText(
                  title: _homeController.failureMessage.value,
                )),
          );
        } else if (_homeController.isLoadingHome.value) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: _homeController
                      .resultHomeUsers.value.data!.users!.length,
                  itemBuilder: (context, index) {
                    var user = _homeController
                        .resultHomeUsers.value.data!.users![index];
                    return Obx(()=>SingleMentorRow(
                      onTap: () {

                        if(_homeController.selectedMentor.where((item) => item.id == user.id).toList().length >= 1) {
                          _homeController.selectedMentor.removeAt(_homeController.selectedMentor.indexWhere((item) => item.id == user.id));
                        }else{
                          _homeController.selectedMentor.add(user);

                        }
                        print(_homeController.selectedMentor.where((item) => item.id == user.id).toList().length);
                        print("*********************************");
                        print(user.id);

                      },
                      btnColor: _homeController.selectedMentor.where((item) => item.id == user.id).toList().length >= 1 ? AppColors.red:AppColors.green,
                      titleBtn: _homeController.selectedMentor.where((item) => item.id == user.id).toList().length >= 1 ? "حذف":"افزودن",
                      isTitle: false,
                      phoneNumber: user.phoneNumber ?? "",
                      fullName: user.fullName ?? "",
                      userName: user.userName ?? "",
                      image: user.profileImage ?? "",
                    ));
                  }),
              SizedBox(
                height: Get.height * 0.07,
              ),
              pageSection(_homeController.resultHomeUsers.value),
            ],
          );
        }
      }),
    ],
  ),
);

Widget pageSection(UsersHomeModel value) {
  return SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        value.data!.totalPages! <= 5
            ? const SizedBox(
          height: 0,
        )
            : const InkWell(
          child: Icon(Icons.double_arrow, color: AppColors.dividerDark),
        ),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 30,
          width: 1,
          color: AppColors.dividerDark,
        ),
        const SizedBox(
          width: 15,
        ),
        ListView.builder(
            itemCount: value.data!.totalPages,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                    () => InkWell(
                  onTap: () {
                    _homeController.selectedPage.value = index + 1;
                    _homeController.fetchUsers(index + 1);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index + 1 == _homeController.selectedPage.value
                            ? AppColors.blueIndigo
                            : Colors.white),
                    child: Center(
                      child: CustomText(
                        title: "${index + 1}",
                        color: index + 1 == _homeController.selectedPage.value
                            ? Colors.white
                            : AppColors.dividerDark,
                      ),
                    ),
                  ),
                ),
              );
            }),
        const SizedBox(
          width: 15,
        ),
        Container(
          height: 30,
          width: 1,
          color: AppColors.dividerDark,
        ),
        const SizedBox(
          width: 15,
        ),
        value.data!.totalPages! <= 5
            ? const SizedBox(
          height: 0,
        )
            : const InkWell(
          child: Icon(
            Icons.double_arrow,
            color: AppColors.dividerDark,
          ),
        ),
      ],
    ),
  );
}
