import 'package:biztalk_panel_admin/model/mentro/user_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/create_off/create_off_dialog.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_and_session_page.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/middle_container_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_title_table_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_user/single_user_controller.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserSectionWidget extends StatelessWidget {
  final UserModel value;
  final String? id;

  UserSectionWidget({Key? key, required this.value, this.id}) : super(key: key);
  final SingleUserController _singleUserController = Get.find();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            children: [
              Expanded(
                child: MiddleContainerWidget(
                  colors: AppColors.greenBank,
                  onTap: () {
                    Get.toNamed(TransactionPage.route, arguments: {
                      "image": value.data!.profile!.profile ?? "",
                      "fullName": value.data!.profile!.fullName,
                      "jobTitle": value.data!.profile!.userName,
                      "typeUser": "mentor",
                      "id": value.data!.profile!.id,
                    });
                  },
                  title: "گردش حساب",
                  isBullet: value.data!.profile!.isConfirmDocs! ? true : false,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: const MiddleContainerWidget(
                  title: "نقد و نظرات کاربران",
                  colors: AppColors.orangHome,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: MiddleContainerWidget(
                  colors: AppColors.blueSession,
                  onTap: () {
                    Get.to(() => RequestAndSessionPage(
                          userType: "user",
                          userID: id!,
                      profile: value.data!.profile,

                        ));
                  },
                  title: "درخواست ها و جلسات",
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: MiddleContainerWidget(
                  colors: AppColors.blueSession,
                  title: "تعریف کد تخفیف",
                  onTap: () {
                    createOffer(context,
                        title: "تعریف کد تخفیف",
                        id: id,
                        name: _singleUserController
                            .resultFetchUser.value.data!.profile!.fullName,
                        userType: 'user');
                  },
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Container())
            ],
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          mainSection(value),
          SizedBox(
            height: Get.height * 0.03,
          ),
        ],
      );

  mainSection(UserModel value) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const ProfileTitleTableWidget(
            isTitle: true,
            userName: "نام مشاور",
            stateTitle: "وضعیت",
            createDate: "تاریخ ایجاد درخواست",
            sessionDate: "زمان جلسه",
            subject: "موضوع",
            state: null,
          ),
          value.data!.requests!.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 100),
                  child: Center(
                      child: CustomText(
                    title: "جلسه ای برای نمایش وجود ندارد",
                  )))
              : ListView.builder(
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
