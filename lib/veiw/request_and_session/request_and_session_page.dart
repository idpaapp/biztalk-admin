import 'package:biztalk_panel_admin/model/all_request_session_model.dart';
import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/responsive/select_date_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/profile_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/session_dialog/session_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/request_date_filter_widget.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/status_filter_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_title_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestAndSessionPage extends StatelessWidget {
  final String? userType;
  final String userID;
  final dynamic profile;

  RequestAndSessionPage(
      {Key? key, this.userType, required this.userID, required this.profile})
      : super(key: key) {
    _requestSessionController.getAllRequestSession({
      "page": _requestSessionController.selectedPage.value,
      "type": userType,
      "status": ["draft", "confirmed", "reserved", "completed"],
      "requestFromDate": null,
      "requestToDate": null,
      "sessionFromDate": null,
      "sessionToDate": null
    }, userID);
  }

  final HomeController _homeController = Get.find();

  final RequestSessionController _requestSessionController =
      Get.put(RequestSessionController());
  String startDateRequest = "";
  String startDateSession = "";
  String endDateRequest = "";
  String endDateSession = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        body: body(context),
      );

  body(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const TopSectionPanelAdmin(title: "کاربران" " /" "مشاور"),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
              child: ProfileSectionWidget(
                paddingBottom: 20,
                tab: const SizedBox(height: 0),
                activeEdit: false,
                isUser: userType == "user" ? true : false,
                image: profile.profile ?? "",
                onEdit: () {
                  showMyDialog(context);
                },
                fullName: profile.fullName ?? "",
                jobTitle: userType == "user"
                    ? ""
                    : profile == null
                        ? ""
                        : profile.jobTitle ?? "",
              ),
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            mainSection(context)
          ],
        ),
      );

  mainSection(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            filterSection(context),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 4,
              child: Obx(() {
                if (_requestSessionController.failureMessageGetAll.value !=
                    "") {
                  return Center(
                    child: CustomText(
                        title: _requestSessionController
                            .failureMessageGetAll.value),
                  );
                } else if (_requestSessionController.isLoadingGetAll.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return leftSectin();
                }
              }),
            )
          ],
        ),
      );

  Widget filterSection(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TypeFilterWidget(),

            StatusFilterSectionWidget(),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => RequestDateFilterWidget(
                title: "تاریخ ایجاد درخواست",
                selectEndDatee:
                    _requestSessionController.selectedEndDateRequest.value,
                onTapSelectEnd: () {
                  selectDateDialog(context, onChange: (val) {
                    endDateRequest = val;
                  }, onConfirm: () {
                    _requestSessionController.selectedEndDateRequest.value =
                        endDateRequest;
                    Get.back();
                  });
                },
                selectStartDatee:
                    _requestSessionController.selectedStartDateRequest.value,
                onTapSelectStart: () {
                  selectDateDialog(context, onChange: (val) {
                    startDateRequest = val;
                  }, onConfirm: () {
                    _requestSessionController.selectedStartDateRequest.value =
                        startDateRequest;
                    Get.back();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => RequestDateFilterWidget(
                title: "تاریخ جلسه",
                selectEndDatee:
                    _requestSessionController.selectedEndDateSession.value,
                onTapSelectEnd: () {
                  selectDateDialog(context, onChange: (val) {
                    endDateSession = val;
                  }, onConfirm: () {
                    _requestSessionController.selectedEndDateSession.value =
                        endDateSession;
                    Get.back();
                  });
                },
                selectStartDatee:
                    _requestSessionController.selectedStartDateSession.value,
                onTapSelectStart: () {
                  selectDateDialog(context, onChange: (val) {
                    startDateSession = val;
                  }, onConfirm: () {
                    _requestSessionController.selectedStartDateSession.value =
                        startDateSession;
                    Get.back();
                  });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ButtonText(
                    onPressed: () {
                      Map<String, dynamic> body = {
                        "page": _requestSessionController.selectedPage.value,
                        "type": userType,
                        "status": _requestSessionController.selectedStatus,
                        "requestFromDate": _requestSessionController
                            .selectedStartDateRequest.value,
                        "requestToDate": _requestSessionController
                            .selectedEndDateRequest.value,
                        "sessionFromDate": _requestSessionController
                            .selectedStartDateSession.value,
                        "sessionToDate": _requestSessionController
                            .selectedEndDateSession.value
                      };

                      _requestSessionController.getAllRequestSession(
                          body, userID);
                    },
                    text: "اعمال فیلتر",
                    height: 45,
                    fontSize: 14,
                    textColor: Colors.white,
                    bgColor: AppColors.blueSession,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 1,
                  child: ButtonText(
                    onPressed: () {
                      confirmDialog(context,
                          title: "آیا برای حذف فیلتر اطمینان دارید؟",
                          onConfirm: () {
                        _requestSessionController.deleteData();
                        _requestSessionController.getAllRequestSession({
                          "page": _requestSessionController.selectedPage.value,
                          "type": userType,
                          "status": [
                            "draft",
                            "confirmed",
                            "reserved",
                            "completed"
                          ],
                          "requestFromDate": null,
                          "requestToDate": null,
                          "sessionFromDate": null,
                          "sessionToDate": null
                        }, userID);
                        Get.back();
                      });
                    },
                    text: "حذف",
                    height: 45,
                    fontSize: 14,
                    textColor: AppColors.red,
                    activeBorder: 1,
                    borderColor: AppColors.red,
                    bgColor: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      );

  Widget leftSectin() => Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.dividerLight),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileTitleTableWidget(
              isTitle: true,
              userName: userType == "user" ? "نام مشاور" : "درخواست دهنده",
              stateTitle: "وضعیت",
              createDate: "تاریخ ایجاد درخواست",
              sessionDate: "زمان جلسه",
              subject: "موضوع",
              state: null,
            ),
            _requestSessionController.resultGetAll.value.data!.docs!.isEmpty
                ? SizedBox(
                    height: Get.height * 0.5,
                    child: const Center(
                        child: CustomText(
                      title: "جلسه یا درخواستی برای نمایش وجود ندارد",
                      fontSize: 14,
                      color: AppColors.blueSession,
                    )),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _requestSessionController
                        .resultGetAll.value.data!.docs!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = _requestSessionController
                          .resultGetAll.value.data!.docs![index];
                      return ProfileTitleTableWidget(
                        isTitle: false,
                        onTap: () async {
                          if (data.type == "session") {
                            MyAlert.loding();
                            await _homeController.singleSession(data.id!);
                            if (_homeController
                                    .failureMessageSingleSession.value !=
                                "") {
                              Get.back();
                              MyAlert.mySnakbarRed(
                                  text: _homeController
                                      .failureMessageSingleSession.value);
                              return;
                            } else {
                              Get.back();
                              Session my = Session(
                                  id: data.id,
                                  date: data.date,
                                  description: data.description,
                                  formattedPrice:
                                      data.time!.formattedPrice ?? "",
                                  status: data.status,
                                  fromNow: "",
                                  price: data.time!.price,
                                  startTime: data.time!.start!,
                                  statusTitle: data.statusTitle,
                                  user: Mentor(profileImageUrl: data.profileImageUrl,id: data.id,phoneNumber: "0919",fullName: "sdkd"),
                                  timeId: data.time!.id,
                                  mentor: Mentor(
                                    fullName: profile.fullName ?? "",
                                    phoneNumber: profile.phone,
                                    id: profile.id,
                                    profileImageUrl: profile.profile,
                                  ));
                              sessionDialog(context, "جلسه", my,
                                  _homeController.resultSingleSession.value);
                            }
                          } else {}
                        },
                        userName: data.person!.fullName ?? "نا مشخص",
                        stateTitle: data.statusTitle ?? "نا مشخص",
                        createDate: data.date ?? "نا مشخص",
                        sessionDate: data.time == null
                            ? "نا مشخص"
                            : data.time!.sessionTime ?? "نا مشخص",
                        subject: data.subject == null
                            ? "نا مشخص"
                            : data.subject!.title ?? "نا مشخص",
                        state: index == 0
                            ? "red"
                            : index == 1
                                ? "pink"
                                : "blue",
                      );
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
            _requestSessionController.resultGetAll.value.data!.docs!.isEmpty
                ? const SizedBox(
                    width: 0,
                  )
                : pageSection(_requestSessionController.resultGetAll.value),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      );

  Widget pageSection(AllRequestSessionModel value) {
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
                    _requestSessionController.getAllRequestSession({
                      "page": index + 1,
                      "type": userType,
                      "status": ["draft", "confirmed", "reserved"],
                      "requestFromDate": null,
                      "requestToDate": null,
                      "sessionFromDate": null,
                      "sessionToDate": null
                    }, userID);
                    _requestSessionController.selectedPage.value = index + 1;
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: index + 1 ==
                                _requestSessionController.selectedPage.value
                            ? AppColors.blueIndigo
                            : Colors.white),
                    child: Center(
                      child: CustomText(
                        title: "${index + 1}",
                        color: index + 1 ==
                                _requestSessionController.selectedPage.value
                            ? Colors.white
                            : AppColors.dividerDark,
                      ),
                    ),
                  ),
                ),
              );
            },
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
}
