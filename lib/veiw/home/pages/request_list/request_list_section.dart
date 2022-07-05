import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/request_list/single_request_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/row_bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class RequestListSection extends StatelessWidget {
  RequestListSection({Key? key}) : super(key: key){
    _homeController.selectedPage.value =1;

    _homeController.requestList(1);
  }
  final HomeController _homeController = Get.find();

  @override
  Widget build(BuildContext context) =>Container(
    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5), color: Colors.white),
    child: Column(
      children: [

        const RowBankWidget(
          isRequestList: true,
          isTitle: true,
          oneColumn: "نام درخواست دهنده",
          twoColumn: "نام مشاور",
          threeColumn: "زمان ثبت",
          fourColumn: "موضوع",
          fiveColumn: "وضعیت",


        ),
        Obx(() {
          if (_homeController.failureMessageRequestList.value != "") {
            return SizedBox(
              height: 100,
              width: Get.width,
              child: Center(
                  child: CustomText(
                    title: _homeController.failureMessageRequestList.value,
                  )),
            );
          } else if (_homeController.isLoadingRequestList.value) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }  else {
            return Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _homeController
                        .resultRequestList.value.data!.request!.length,
                    itemBuilder: (context, index) {
                      var request =_homeController
                          .resultRequestList.value.data!.request![index];
                      return   RowBankWidget(
                        isTitle: false,
                        oneColumn: request.user!.fullName ??"",
                        twoColumn:request.mentor!.fullName ??"",
                        threeColumn: request.createdAt??"",
                        fourColumn: request.subject!.title??"",
                        isRequestList: true,

                        fiveColumn:request.status??"",
                        onTap: ()async{


                         MyAlert.loding();
                         await _homeController.singleRequest(request.id!);
                         Get.back();
                         if(_homeController.failureMessageSingleRequest.value !=""){
                           MyAlert.mySnakbarRed(text: _homeController.failureMessageSingleRequest.value);
                         }else{
                           requestDialog(context,"درخواست",request,_homeController.resultSingleRequest.value);
                         }

                          //
                          //
                          // confirmDialog(context,title: "آیا برای تایید اطمینان دارید؟",onConfirm: ()async{
                          //   // MyAlert.loding();
                          //   // await _homeController.VerifyAccount(user.userId!, true);
                          //   // if(_homeController.resultVerifyAccount.value.ok ==true){
                          //   //   Get.back();
                          //   //   Get.back();
                          //   //   Get.back();
                          //   //   await _homeController.notVerify(1);
                          //   //   MyAlert.mySnakbar(title: "عملیات موفق",text: "حساب با موفقیت تایید شد");
                          //   // }
                          // });

                        },

                      );
                    }),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                pageSection(),

              ],
            );
          }
        }),

      ],
    ),
  );

  Widget pageSection() {
    var data = _homeController.resultRequestList.value.data!;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.totalPages! <= 5
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
              itemCount: data.totalPages,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                      () => InkWell(
                    onTap: () {
                      _homeController.selectedPage.value = index + 1;
                      _homeController.requestList(index + 1);
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
          data.totalPages! <= 5
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
