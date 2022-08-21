import 'package:biztalk_panel_admin/model/transaction/not_verify_account_model.dart';
import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/global_info.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/other_dialog/widget/row_text_widget.dart';
import 'package:biztalk_panel_admin/veiw/home/pages/bank_section/bank_account_controller.dart';
import 'package:flutter/material.dart';

import '../edit_profile_dialog/title_widget.dart';
import 'package:get/get.dart';

final BankAccountController _bankAccountController =
    Get.put(BankAccountController());

Future<void> singleTransactionDialog(
    BuildContext context, String title, AccountDatum single, onConfirm) async {
  _bankAccountController.accountName.value="";
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
          size: 1,
          title: title,
        ),
        content: SizedBox(
          height: Get.height * 0.6,
          width: Get.width * 0.5,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.02, vertical: Get.height * 0.005),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  single.profileImageUrl == null
                      ? const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                              "assets/images/avatar_placeholder.png"),
                        )
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              GlobalInfo.serverAddress +
                                  "/" +
                                  single.profileImageUrl!),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  RowTextWidget(
                    title: "نام و نام خانوادگی :",
                    subTitle: single.fullName ?? "",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RowTextWidget(
                    title: "نام کاربری :",
                    subTitle: single.userName ?? "",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RowTextWidget(
                    title: "نوع کاربری :",
                    subTitle: single.userType ?? "",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      RowTextWidget(
                        title: "شبا :",
                        subTitle: single.iban ?? "",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: InkWell(
                            onTap: () async{
                              MyAlert.loding();
                              await _bankAccountController.checkIban("IR" + single.iban!);
                              Get.back();
                              if(_bankAccountController.failureMessageCheckIban.value !=""){
                                MyAlert.mySnakbarRed(text:_bankAccountController.failureMessageCheckIban.value );
                              }else{
                                _bankAccountController.accountName.value=_bankAccountController.resultCheckIban.value.data!.name!;
                              }

                            },
                            child: const CustomText(
                              title: "استعلام",
                              color: AppColors.darkerGreen,
                              fontSize: 14,
                            )),
                      )
                    ],
                  ),
                  Obx(()=>_bankAccountController.resultCheckIban.value.result ==1 ? RowTextWidget(
                    isSubtitle: true,
                    title: " ",
                    subTitle: " شماره شبا متعلق به  ${_bankAccountController.resultCheckIban.value.data!.name}  بانک  ${_bankAccountController.resultCheckIban.value.data!.bankName} می باشد .",
                  ):SizedBox(height: 0,)),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => RowTextWidget(
                      title: "نام صاحب شبا :",
                      subTitle: _bankAccountController.accountName.value,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(children: [
                    Expanded(child: Container()),
                    Expanded(flex: 2,child:                   Obx(
                          () =>
                              Container(
                                margin:
                                const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.bgText,
                                    border: Border.all(color:AppColors.bgText)),
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: const SizedBox(height: 0),
                                  value: _bankAccountController.selectedBankId.value,
                                  items:
                                  _bankAccountController.resultGetBank.value.data!.map((
                                      value) {
                                    return DropdownMenuItem(
                                      value: value.id,
                                      child: ListTile(
                                        title: CustomText(
                                            title: value.title, fontSize: 14,color: AppColors.lighterBlack,                fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value){
                                    _bankAccountController.selectedBankId.value=value.toString();
                                  },
                                ),
                              )
                    ),
                    )
                  ],),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: onConfirm,
                  text: "تایید",
                  borderRadios: 3,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  textColor: Colors.white,
                  bgColor: AppColors.blueBg,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 3,
                  onPressed: () {
                    Get.back();
                  },
                  text: "عدم تایید",
                  height: 40,
                  width: Get.width * 0.1,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.black,
                  bgColor: AppColors.disabledGrey,
                ),
              ],
            ),

            // child: Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // ButtonText(
            //     //   onPressed: () {},
            //     //   text: "استعلام",
            //     //   borderRadios: 3,
            //     //   fontWeight: FontWeight.w500,
            //     //   height: 40,
            //     //   width: Get.width * 0.1,
            //     //   fontSize: 14,
            //     //   textColor: Colors.white,
            //     //   bgColor: AppColors.green,
            //     // ),
            //
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         ButtonText(
            //           onPressed: onConfirm,
            //           text: "تایید",
            //           borderRadios: 3,
            //           fontWeight: FontWeight.w500,
            //           height: 40,
            //           width: Get.width * 0.1,
            //           fontSize: 14,
            //           textColor: Colors.white,
            //           bgColor: AppColors.blueBg,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         ButtonText(
            //           borderRadios: 3,
            //           onPressed: () {
            //             Get.back();
            //           },
            //           text: "عدم تایید",
            //           height: 40,
            //           width: Get.width * 0.1,
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           textColor: Colors.black,
            //           bgColor: AppColors.disabledGrey,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          )
        ],
      );
    },
  );
}
