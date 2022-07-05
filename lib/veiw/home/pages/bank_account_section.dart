import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/dialog_confirm/confirm_dialog.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/single_transaction_dialog.dart';
import 'package:biztalk_panel_admin/veiw/home/home_controller.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/row_bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class BankAccountSection extends StatelessWidget {
   BankAccountSection({Key? key}) : super(key: key){
     _homeController.selectedPage.value =1;
     _homeController.notVerify(1);
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
          isTitle: true,
          oneColumn: "نام و نام خانوادگی",
          twoColumn: "نام کاربری",
          threeColumn: "نوع کاربر",
          shebaNumber: "شبا",
          fourColumn: "بانک",
          fiveColumn: "شماره تلفن",

        ),
        Obx(() {
          if (_homeController.failureMessageNotVerify.value != "") {
            return SizedBox(
              height: 100,
              width: Get.width,
              child: Center(
                  child: CustomText(
                    title: _homeController.failureMessageNotVerify.value,
                  )),
            );
          } else if (_homeController.isLoadingNotVerify.value) {
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
                        .resultNotVerify.value.data!.accountData!.length,
                    itemBuilder: (context, index) {
                      var user = _homeController
                          .resultNotVerify.value.data!.accountData![index];
                      return   RowBankWidget(
                        isTitle: false,
                        oneColumn: user.fullName??"",
                        twoColumn: user.userName??"",
                        threeColumn: user.userType??"",
                        shebaNumber: user.iban??"",
                        fourColumn:user.bank!.name??"",
                        fiveColumn: user.phone??"",
                        onTap: (){
                            singleTransactionDialog(context,"تایید حساب بانکی",user,(){
                              confirmDialog(context,title: "آیا برای تایید اطمینان دارید؟",onConfirm: ()async{
                                MyAlert.loding();
                                await _homeController.VerifyAccount(user.userId!, true);
                                if(_homeController.resultVerifyAccount.value.ok ==true){
                                  Get.back();
                                  Get.back();
                                  Get.back();
                                  await _homeController.notVerify(1);
                                  MyAlert.mySnakbar(title: "عملیات موفق",text: "حساب با موفقیت تایید شد");
                                }
                              });
                            });

                        },

                      );
                    }),
                SizedBox(
                  height: Get.height * 0.07,
                ),
                pageSection()
              ],
            );
          }
        }),
      ],
    ),
  );
   Widget pageSection() {
     var data = _homeController.resultNotVerify.value.data!;
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
                       _homeController.notVerify(index + 1);
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
