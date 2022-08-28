import 'package:biztalk_panel_admin/resources/all_methods.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/veiw/comment/comment_controller.dart';
import 'package:biztalk_panel_admin/veiw/comment/single_comment_dialog.dart';
import 'package:biztalk_panel_admin/veiw/comment/widgets/comment_list_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CommentPage extends StatelessWidget {
   CommentPage({Key? key}) : super(key: key);
  final CommentController _commentController =Get.put(CommentController());

  @override
  Widget build(BuildContext context) => Scaffold(
    body:Obx((){if(_commentController.failureMessageGetComments.value !=""){
      return Center(child: CustomText(title: _commentController.failureMessageGetComments.value),);
    }else if(_commentController.isLoadingageGetComments.value){
      return const Center(child: CircularProgressIndicator(),);
    }else{
      return  body(context);
    }})
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Center(child: CustomText(title: "میانگین امتیاز",color: AppColors.black,fontSize: 14,fontWeight: FontWeight.bold)),
              const SizedBox(width: 12,),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:AllMethods.commentColor(4.3)
                  ),

                  child: const CustomText(
                      fontSize:  12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      title: "4.3")
              ),
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

        Expanded(
          flex: 4,
          child: leftSectin()

          ),

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
          statusRate: "SINA",

        ),
       ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return CommentListWidget(
              isTitle: false,
              onTap: () async {
                singleCommentDialog(context,);
              },
              fullName: "سینا جمشیدی",
              createDate: "12:25 1401/02/27",
              comment: " قبدق ل قل  ی  ی ب  ی ب ی ب نظر ثبت شده",
              rate: index == 0 ? 1.2:index==1 ?2.2:index==2 ?3.2:index==3?4.2:index == 4?0.7:4.9,
              statusRate: "SINA",
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
       // pageSection(_requestSessionController.resultGetAll.value),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );


  // Widget pageSection(AllRequestSessionModel value) {
  //   print(value.data!.totalPages);
  //   return SizedBox(
  //     height: 40,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         value.data!.totalPages! <= 5
  //             ? const SizedBox(
  //           height: 0,
  //         )
  //             : const InkWell(
  //           child: Icon(Icons.double_arrow, color: AppColors.dividerDark),
  //         ),
  //         const SizedBox(
  //           width: 15,
  //         ),
  //         Container(
  //           height: 30,
  //           width: 1,
  //           color: AppColors.dividerDark,
  //         ),
  //         const SizedBox(
  //           width: 15,
  //         ),
  //         ListView.builder(
  //           itemCount: value.data!.totalPages,
  //           shrinkWrap: true,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             return Obx(
  //                   () => InkWell(
  //                 onTap: () {
  //
  //                   _requestSessionController.selectedPage.value = index + 1;
  //                   _requestSessionController.getAllRequestSession({
  //                     "page": _requestSessionController.selectedPage.value,
  //                     "type": userType,
  //                     "status":_requestSessionController.selectedStatus,
  //                     "requestFromDate": _requestSessionController
  //                         .selectedStartDateRequest.value == "انتخاب کنید" ? null:_requestSessionController
  //                         .selectedStartDateRequest.value,
  //                     "requestToDate": _requestSessionController
  //                         .selectedEndDateRequest.value== "انتخاب کنید" ? null:_requestSessionController
  //                         .selectedEndDateRequest.value,
  //                     "sessionFromDate": _requestSessionController
  //                         .selectedStartDateSession.value== "انتخاب کنید" ? null:_requestSessionController
  //                         .selectedStartDateSession.value,
  //                     "sessionToDate": _requestSessionController
  //                         .selectedEndDateSession.value== "انتخاب کنید" ? null:_requestSessionController
  //                         .selectedEndDateSession.value
  //                   }, userID);
  //                   print( _requestSessionController.selectedPage.value);
  //                 },
  //                 child: Container(
  //                   width: 40,
  //                   height: 40,
  //                   decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10),
  //                       color: index + 1 ==
  //                           _requestSessionController.selectedPage.value
  //                           ? AppColors.blueIndigo
  //                           : Colors.white),
  //                   child: Center(
  //                     child: CustomText(
  //                       title: "${index + 1}",
  //                       color: index + 1 ==
  //                           _requestSessionController.selectedPage.value
  //                           ? Colors.white
  //                           : AppColors.dividerDark,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         const SizedBox(
  //           width: 15,
  //         ),
  //         Container(
  //           height: 30,
  //           width: 1,
  //           color: AppColors.dividerDark,
  //         ),
  //         const SizedBox(
  //           width: 15,
  //         ),
  //         value.data!.totalPages! <= 5
  //             ? const SizedBox(
  //           height: 0,
  //         )
  //             : const InkWell(
  //           child: Icon(
  //             Icons.double_arrow,
  //             color: AppColors.dividerDark,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}