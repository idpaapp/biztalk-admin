import 'package:biztalk_panel_admin/model/mentro/user_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/create_off/create_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_user_profile/edit_user_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/single_mentor_page.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_controller.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/widget/top_section_panel_admin.dart';
import '../request_and_session/request_and_session_page.dart';
import '../single_mentor/widgets/middle_container_widget.dart';
import '../single_mentor/widgets/profile_section_widget.dart';
import '../single_mentor/widgets/profile_title_table_widget.dart';

class SingleUserPage extends StatelessWidget {
  static const route = "/singleUserPage";

  late String id;
  late String userType;

  SingleUserPage({
    Key? key,
  }) : super(key: key) {
    id = Get.arguments['id'];
    userType = Get.arguments['userType'];
    print(id);
    print(userType);
    print("454544545454554");
    _singleUserController.fetchUser(id);
  }

  final SingleUserController _singleUserController =
      Get.put(SingleUserController());
  final HomeController _homeController =Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.dividerLight,
        body: Obx(() {
          if (_singleUserController.failureMessageFetchUser.value != "") {
            return Center(
              child: CustomText(
                  title: _singleUserController.failureMessageFetchUser.value),
            );
          } else if (_singleUserController.isLoadingFetchUser.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return getBody(
                context, _singleUserController.resultFetchUser.value);
          }
        }));
  }

  Widget getBody(BuildContext context, UserModel value) {

    _singleUserController.switchValue.value =
        value.data!.profile!.status == "ACTIVE" ? true : false;

    return SingleChildScrollView(
      child: Column(children: [
        TopSectionPanelAdmin(
            title: "کاربران" " /" "rout",
            onDashbord: () {
              Get.back();
            }),
        SizedBox(
          height: Get.height * 0.07,
        ),
      Obx(()=>  ProfileSectionWidget(
        userType: userType,
        showSwitch: true,
        onSwitchBtn: () {
          Get.offAndToNamed(SingleMentorPage.route, arguments: {"id": id,"userType":userType});

        },
        isUser: true,
        switchValue:_singleUserController.switchValue.value,
        statustitle: value.data!.profile!.statusTitle,
        status: value.data!.profile!.status,
        onSwitchChange: (valueSwitch)async{
          MyAlert.loding();
          await _singleUserController.changeStatus(value.data!.profile!.id.toString(), valueSwitch ? "ACTIVE" :"DE_ACTIVE");
          Get.back();
          if(_singleUserController.failureMessageChangeStatus.value !=""){
            MyAlert.mySnakbarRed(text: _singleUserController.failureMessageChangeStatus.value);
          }else{
            _singleUserController.switchValue.value=valueSwitch;
            _homeController.fetchInfoHome();
            _homeController.fetchUsers(1);


          }

        },
        image: value.data!.profile!.profile ?? "",
        onEdit: () {
          editUserProfile(
            context,
            phone: value.data!.profile!.phone ?? "",
            id: value.data!.profile!.id,
            fullName: value.data!.profile!.fullName ?? "",
            userName: value.data!.profile!.userName ?? "",
            image: value.data!.profile!.profile ?? "",
            onConfirmImage: () {},
          );
        },
        fullName: value.data!.profile!.fullName ?? "",
        jobTitle: "",
      ),),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
          child: Row(
            children: [
              MiddleContainerWidget(
                onTap: () {
                  print( {"image": value.data!.profile!.profile!,
                    "fullName": value.data!.profile!.fullName,
                    "jobTitle": value.data!.profile!.userName,
                    "typeUser": "mentor",
                    "id": value.data!.profile!.id},);
                  // Get.toNamed(TransactionPage.route, arguments: {
                  //   "image": value.data!.profile!.profile!,
                  //   "fullName": value.data!.profile!.fullName,
                  //   "jobTitle": value.data!.profile!.userName,
                  //   "typeUser": "mentor",
                  //   "id": value.data!.profile!.id,
                  // });
                },
                title: "گردش حساب",
                detail: "4.3145000 ریال تسویه نشده",
                isBottomIcon: false,
                isBullet: value.data!.profile!.isConfirmDocs! ? true : false,
              ),
              const SizedBox(
                width: 40,
              ),
              const MiddleContainerWidget(
                title: "نقد و نظرات کاربران",
                detail: "4.3 امتیاز کسب شده",
              ),
              const SizedBox(
                width: 40,
              ),
              MiddleContainerWidget(
                onTap: () {
                  Get.to(() => RequestAndSessionPage(
                        userType: "mentor",
                      ));
                },
                title: "درخواست ها و جلسات",
                detail: "",
                isBottomIcon: false,
              ),
              const SizedBox(
                width: 40,
              ),
              MiddleContainerWidget(
                title: "تعریف کد تخفیف",
                detail: "",
                isBottomIcon: false,
                onTap: () {
                  createOffer(context,title: "تعریف کد تخفیف",id: id,name: _singleUserController.resultFetchUser.value.data!.profile!.fullName,userType: 'user');

                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        mainSection(value),
        SizedBox(
          height: Get.height * 0.03,
        ),
      ]),
    );
  }

  mainSection(UserModel value) => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
            title: "چیزها",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterBlack,
          ),
          const SizedBox(
            height: 20,
          ),
          const ProfileTitleTableWidget(
            isTitle: true,
            userName: "نام مشاور",
            stateTitle: "وضعیت",
            createDate: "تاریخ ایجاد درخواست",
            sessionDate: "زمان جلسه",
            subject: "موضوع",
            state: null,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: value.data!.requests!.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var user = value.data!.requests![index];
                return ProfileTitleTableWidget(
                  isTitle: false,
                  userName: user.requestOwnerName ?? "نا مشخص",
                  stateTitle: user.statusTitle ?? "نا مشخص",
                  createDate: user.createdAt ?? "نا مشخص",
                  sessionDate: user.endTime ?? "نا مشحص",
                  subject: user.subject ?? "نا مشخص",
                  state: user.status ?? "نا مشخص",
                );
              }),
          const SizedBox(
            height: 20,
          ),
        ]),
      );
}
