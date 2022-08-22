import 'package:biztalk_panel_admin/model/contact/mentor_contact_model.dart';
import 'package:biztalk_panel_admin/model/tv/mentor_tv_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/tv/dilog/edit_contact_dialog.dart';
import 'package:biztalk_panel_admin/veiw/tv/dilog/edit_tv_dialog.dart';
import 'package:biztalk_panel_admin/veiw/tv/tv_controller.dart';
import 'package:biztalk_panel_admin/veiw/tv/widgets/tv_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../home/widget/top_section_panel_admin.dart';
import '../single_mentor/widgets/profile_section_widget.dart';

class TvPage extends StatelessWidget {
  static const route = "/tvPage";
  late String image;
  late String id;
  late String fullName;
  late String jobTitle;
  final TvController _controller = Get.put(TvController());

  TvPage({Key? key}) : super(key: key) {
    image = Get.arguments['image'] ?? "";
    id = Get.arguments['id'];
    fullName = Get.arguments['fullName'];
    jobTitle = Get.arguments['jobTitle'] ?? "";
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: AppColors.veryLightGrey, body: getBody(context));

  Widget getBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const TopSectionPanelAdmin(title: "رسانه ها"),
            SizedBox(
              height: Get.height * 0.07,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
              child: ProfileSectionWidget(
                tab: const SizedBox(height: 20),
                activeEdit: false,
                isTransaction: false,
                isUser: false,
                image: image,
                onEdit: () {},
                fullName: fullName,
                jobTitle: jobTitle,
                widget: Container(),
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            StreamBuilder<Widget>(
              initialData: const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context, snapshot) => snapshot.data!,
              stream: _controller.fetchMentorTv(
                  id: id,
                  onLoading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  onFailure: (message) => Center(
                        child: Text(message),
                      ),
                  onSuccess: (value) => tvSection(value!, context)),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            StreamBuilder<Widget>(
              initialData: const Center(
                child: CircularProgressIndicator(),
              ),
              builder: (context, snapshot) => snapshot.data!,
              stream: _controller.fetchMentorContact(
                  id: id,
                  onLoading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  onFailure: (message) => Center(
                        child: Text(message),
                      ),
                  onSuccess: (value) => contactSection(value!, context)),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );

  tvSection(MentorTvsModel value, BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const CustomText(
                title: "رسانه",
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.lighterBlack,
              ),
              const SizedBox(
                height: 20,
              ),
              const TvRowWidget(
                isTitle: true,
                type: "نوع کانال",
                image: "",
                address: "آدرس",
                publishStatusTitle: "وضعیت انتشار",
                statusTitle: "وضعیت",
              ),
              value.data!.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                          child: CustomText(
                        title: "اطلاعاتی یافت نشد",
                      )),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.data!.length,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var tv = value.data![index];
                        return TvRowWidget(
                          onConfirm: () {
                            confirmDialog(context,
                                title: "آیا برای تایید رسانه اطمینان دارید؟",
                                onConfirm: () async {
                              Map<String, dynamic> body = {
                                "_id": tv.id,
                                "type": "tv"
                              };
                              MyAlert.loding();
                              await _controller.confirmTvOrContact(body, id);
                              if (_controller.failureMessageConfirm.value ==
                                      "" &&
                                  _controller.resultConfirm.value.ok == true) {
                                Get.back();
                                Get.back();
                                Get.offAndToNamed(TvPage.route, arguments: {
                                  "image": image,
                                  "fullName": fullName,
                                  "jobTitle": jobTitle,
                                  "id": id,
                                });
                              } else {
                                Get.back();
                                MyAlert.mySnakbarRed(
                                    text: _controller
                                        .failureMessageConfirm.value);
                              }
                            });
                          },
                          isTitle: false,
                          type: tv.tvTitle,
                          image: tv.tvLogo,
                          address: tv.tvLink! + tv.userName!,
                          status: tv.status,
                          onLink: () async {


                            if (tv.tvLink! == null || tv.tvLink! == "") {
                              final Uri _url =
                                  Uri.parse(tv.userName!);
                              await launchUrl(_url);
                            } else {
                              print(tv.tvLink! + tv.userName!);
                              await launch(tv.tvLink! + tv.userName!);
                            }
                            //
                          },
                          statusTitle: tv.statusTitle,
                          publishStatus: tv.rePublish,
                          publishStatusTitle: tv.rePublishTitle,
                          onEdit: () {
                            editTvDialog(context,
                                mentorFullName: fullName,
                                isCreate: false,
                                mentorImage: image,
                                mentorJobTitle: jobTitle,
                                userId: id,
                                mainId: tv.id,
                                type: tv.tvTitle,
                                switchBtn: tv.rePublish,
                                title: "رسانه",
                                onConfirm: () {},
                                onDelete: () {},
                                imageType: tv.tvLogo,
                                link: tv.userName);
                          },
                        );
                      }),
              const SizedBox(
                height: 20,
              ),
              //  pageSection()
            ]),
            ButtonText(
              onPressed: () {
                editTvDialog(
                  context,
                  mentorFullName: fullName,
                  mentorImage: image,
                  mentorJobTitle: jobTitle,
                  isCreate: true,
                  userId: id,
                  title: "رسانه",
                );
              },
              borderRadios: 5,
              width: Get.width * 0.07,
              height: Get.height * 0.05,
              fontSize: 14,
              text: "افزودن",
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
              bgColor: AppColors.blueIndigo,
            )
          ],
        ),
      );

  contactSection(MentorContactModel value, BuildContext context) => Container(
        margin: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.01),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  title: "راه های ارتباطی",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lighterBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                const TvRowWidget(
                  isTitle: true,
                  type: "نوع کانال",
                  image: "",
                  isContact: true,
                  address: "آدرس",
                  publishStatusTitle: "وضعیت انتشار",
                  statusTitle: "وضعیت",
                ),
                value.data!.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                            child: CustomText(
                          title: "اطلاعاتی یافت نشد",
                        )),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.data!.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          var contact = value.data![index];
                          return TvRowWidget(
                            onConfirm: () {
                              confirmDialog(
                                context,
                                title:
                                    "آیا برای تایید راه ارتباطی اطمینان دارید؟",
                                onConfirm: () async {
                                  Map<String, dynamic> body = {
                                    "_id": contact.id,
                                    "type": "contact"
                                  };
                                  MyAlert.loding();
                                  await _controller.confirmTvOrContact(
                                      body, id);
                                  if (_controller.failureMessageConfirm.value ==
                                          "" &&
                                      _controller.resultConfirm.value.ok ==
                                          true) {
                                    Get.back();
                                    Get.back();

                                    Get.offAndToNamed(TvPage.route, arguments: {
                                      "image": image,
                                      "fullName": fullName,
                                      "jobTitle": jobTitle,
                                      "id": id,
                                    });
                                  } else {
                                    Get.back();
                                    MyAlert.mySnakbarRed(
                                        text: _controller
                                            .failureMessageConfirm.value);
                                  }
                                },
                              );
                            },
                            onLink: () async {
                              await launch(
                                  contact.contactLink! + contact.userName!);
                            },
                            isContact: true,
                            isTitle: false,
                            type: contact.contactTitle,
                            image: contact.contactLogo,
                            address: contact.contactLink! + contact.userName!,
                            status: contact.status,
                            statusTitle: contact.statusTitle,
                            publishStatus: false,
                            publishStatusTitle: "",
                            onEdit: () {
                              editContactDialog(context,
                                  mentorFullName: fullName,
                                  mentorImage: image,
                                  mentorJobTitle: jobTitle,
                                  userId: id,
                                  isCreate: false,
                                  mainId: contact.id,
                                  type: contact.contactTitle,
                                  title: "راه های ارتباطی",
                                  imageType: contact.contactLogo,
                                  link: contact.userName);
                            },
                          );
                        },
                      ),

                //  pageSection()
              ],
            ),
            ButtonText(
              onPressed: () {
                editContactDialog(
                  context,
                  mentorFullName: fullName,
                  isCreate: true,
                  mentorImage: image,
                  mentorJobTitle: jobTitle,
                  userId: id,
                  title: "راه های ارتباطی",
                );
              },
              borderRadios: 5,
              width: Get.width * 0.07,
              height: Get.height * 0.05,
              fontSize: 14,
              text: "افزودن",
              fontWeight: FontWeight.w500,
              textColor: Colors.white,
              bgColor: AppColors.blueIndigo,
            )
          ],
        ),
      );
}
