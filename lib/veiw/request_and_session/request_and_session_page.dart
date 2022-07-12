import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/responsive/select_date_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/profile_dialog_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/request_session_controller.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/request_date_filter_widget.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/status_filter_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/request_and_session/widgets/type_filter_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_title_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestAndSessionPage extends StatelessWidget {
  final String? userType;
  final String userID;

  RequestAndSessionPage({Key? key, this.userType,required this.userID})
      : super(key: key) {
    _requestSessionController.getAllRequestSession({
      "page": 1,
      "status": ["draft","confirmed","reserved"],
      "requestFromDate": null,
      "requestToDate": null,
      "sessionFromDate": null,
      "sessionToDate": null
    }, userID);
  }

  final RequestSessionController _requestSessionController =
      Get.put(RequestSessionController());
  String startDateRequest = "";
  String startDateSession = "";
  String endDateRequest = "";
  String endDateSession = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Obx(() {
          if (_requestSessionController.failureMessageGetAll.value != "") {
            return Center(child: CustomText(title: _requestSessionController.failureMessageGetAll.value),);
          } else if (_requestSessionController.isLoadingGetAll.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return body(context);
          }
        }),
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
                isUser: userType == "user" ? true : false,
                image:
                    "https://news.varzeshe3.com/pictures/2022/02/14/D/upo3ogpd.jpg",
                onEdit: () {
                  showMyDialog(context);
                },
                fullName: "سینا جمشیدی",
                jobTitle: "متخصص مغز و اعصاب",
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
            leftSectin(),
          ],
        ),
      );

  Widget filterSection(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TypeFilterWidget(),
            const SizedBox(
              height: 20,
            ),
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
          ],
        ),
      );

  Widget leftSectin() => Expanded(
      flex: 4,
      child: Container(
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: _requestSessionController.resultGetAll.value.data!.docs!.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var data=_requestSessionController.resultGetAll.value.data!.docs![index];
                return ProfileTitleTableWidget(
                  isTitle: false,
                  userName: "سینا جمشیدی",
                  stateTitle: "جلسه تمام شده",
                  createDate: "1400/07/18,12:20",
                  sessionDate: "1400/07/18,12:20",
                  subject: data.subject!.title??"نا مشخص",
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
            pageSection()
          ],
        ),
      ));

  Widget pageSection() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const InkWell(
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
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(
                () => InkWell(
                  onTap: () {
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
          const InkWell(
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
