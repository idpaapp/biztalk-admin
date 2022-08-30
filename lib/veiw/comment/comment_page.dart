import 'package:biztalk_panel_admin/model/comment_model.dart';
import 'package:biztalk_panel_admin/resources/all_methods.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/comment/comment_controller.dart';
import 'package:biztalk_panel_admin/veiw/comment/single_comment_dialog.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/comment_list_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentPage extends StatelessWidget {
  final String? mentorID;

  CommentPage({Key? key, this.mentorID}) : super(key: key) {
    _commentController.selectedPage.value = 1;
    _commentController.getComments(
        _commentController.selectedPage.value, mentorID!);
  }

  final CommentController _commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) => Scaffold(body: Obx(() {
        if (_commentController.failureMessageGetComments.value != "") {
          return Center(
            child: CustomText(
                title: _commentController.failureMessageGetComments.value),
          );
        } else if (_commentController.isLoadingageGetComments.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return body(context);
        }
      }));

  body(BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            const TopSectionPanelAdmin(title: "کاربران" " /" "مشاور"),
            const SizedBox(
              height: 12,
            ),
            _commentController
                        .resultagGetComments.value.data!.userSurveyAverage ==
                    null
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: GlobalInfo.pagePadding),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Center(
                            child: CustomText(
                                title: "میانگین امتیاز",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AllMethods.commentColor(
                                    _commentController.resultagGetComments.value
                                        .data!.userSurveyAverage!)),
                            child: CustomText(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                title: _commentController.resultagGetComments
                                    .value.data!.userSurveyAverage!
                                    .toStringAsFixed(1)
                                    .toString())),
                      ],
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            mainSection(context),
          ],
        ),
      );

  mainSection(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: GlobalInfo.pagePadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: leftSectin()),
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
            const CommentListWidget(
              isTitle: true,
              fullName: "نام و نام خانوادگی",
              createDate: "تاریخ ارسال نظر",
              comment: "نظر ثبت شده",
            ),
            _commentController.resultagGetComments.value.data!.data!.isEmpty
                ? SizedBox(
                    height: Get.height * 0.2,
                    child: Center(
                        child: CustomText(
                      title: "نظری یافت نشد",
                    )),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _commentController
                        .resultagGetComments.value.data!.data!.length,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      var comment = _commentController
                          .resultagGetComments.value.data!.data![index];
                      return CommentListWidget(
                        isTitle: false,
                        onTap: () async {
                          MyAlert.loding();
                          await _commentController
                              .getAnswers(comment.surveyAnswerId!);
                          Get.back();
                          if (_commentController
                                  .failureMessageGetAnswers.value !=
                              "") {
                            MyAlert.mySnakbarRed(
                                text: _commentController
                                    .failureMessageGetAnswers.value);
                          } else {
                            singleCommentDialog(context,
                                answersModel: _commentController
                                    .resultGetAnswers.value.data);
                          }
                        },
                        fullName: comment.fullName,
                        createDate: comment.createDate,
                        comment: comment.comment,
                        rate: comment.surveyQuestionAverage ?? 0.0,
                      );
                    },
                  ),
            const SizedBox(
              height: 20,
            ),
            pageSection(_commentController.resultagGetComments.value),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      );

  Widget pageSection(CommentsModel value) {
    print(value.data!.totalPages);
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
                    _commentController.selectedPage.value = index + 1;
                    _commentController.getComments(
                        _commentController.selectedPage.value, mentorID!);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            index + 1 == _commentController.selectedPage.value
                                ? AppColors.blueIndigo
                                : Colors.white),
                    child: Center(
                      child: CustomText(
                        title: "${index + 1}",
                        color:
                            index + 1 == _commentController.selectedPage.value
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
