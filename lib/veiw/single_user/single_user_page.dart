import 'package:biztalk_panel_admin/model/mentro/user_model.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_user_profile/edit_user_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/user_section.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../single_mentor/widgets/profile_section_widget.dart';

class SingleUserPage extends StatelessWidget {
  static const route = "/singleUserPage";

  final String? id;
  final String? userType;

  SingleUserPage({
    Key? key,this.userType,this.id
  }) : super(key: key) {

    _singleUserController.fetchUser(id!);
  }

  final SingleUserController _singleUserController =
      Get.put(SingleUserController());
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) =>Obx(() {
    if (_singleUserController.failureMessageFetchUser.value != "") {
      return Center(
        child: CustomText(
            title: _singleUserController.failureMessageFetchUser.value),
      );
    } else if (_singleUserController.isLoadingFetchUser.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return getBody(
          context, _singleUserController.resultFetchUser.value);
    }
  });

  Widget getBody(BuildContext context, UserModel value) {
    _singleUserController.switchValue.value =
        value.data!.profile!.status == "ACTIVE" ? true : false;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: SingleChildScrollView(
        child: Column(children: [

          Obx(
            () => ProfileSectionWidget(
              tab: const SizedBox(height: 0),
              userType: userType,
              showSwitch: true,
              onSwitchBtn: () {
                // Get.offAndToNamed(SingleMentorPage.route,
                //     arguments: {"id": id, "userType": userType});
              },
              isUser: true,
              switchValue: _singleUserController.switchValue.value,
              statustitle: value.data!.profile!.statusTitle,
              status: value.data!.profile!.status,
              onSwitchChange: (valueSwitch) async {
                MyAlert.loding();
                await _singleUserController.changeStatus(
                    value.data!.profile!.id.toString(),
                    valueSwitch ? "ACTIVE" : "DE_ACTIVE");
                Get.back();
                if (_singleUserController.failureMessageChangeStatus.value !=
                    "") {
                  MyAlert.mySnakbarRed(
                      text:
                          _singleUserController.failureMessageChangeStatus.value);
                } else {
                  _singleUserController.switchValue.value = valueSwitch;
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
            ),
          ),
          UserSectionWidget(
            value: value,
            id: id,

          )
        ]),
      ),
    );
  }
}
