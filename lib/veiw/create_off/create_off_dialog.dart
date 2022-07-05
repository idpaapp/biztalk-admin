import 'dart:math';

import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/button_text.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/resources/my_alert.dart';
import 'package:biztalk_panel_admin/veiw/create_off/off_controller.dart';
import 'package:biztalk_panel_admin/veiw/create_off/widgets/datePiker.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_text_field_widget.dart';
import 'package:biztalk_panel_admin/veiw/dialogs/edit_profile_dialog/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> createOffer(BuildContext context, {String? title,String ? id,String ? name,String? userType}) async {
  final TextEditingController _title = TextEditingController();
  final OffController _offController = Get.put(OffController());

  List option = ["همه دسته بندی ها", " انتخاب دسته بندی"];
  List type = ["درصدی", "مبلغی"];
  _offController.deleteData();

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      _offController.fetchCategory();
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        title: TitleWidget(
            size: 4,
            title: title!,
            ),
        content: Container(
          height: Get.height * 0.6,
          width: Get.width * 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    rightColumn(_title, option, _offController,name:name ),
                    leftColumn(type, _offController),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10, horizontal:Get.width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonText(
                  onPressed: () async {
                    Map<String, dynamic> body = {
                      "title": _title.text,
                      "discountPercent": _offController.selectedType.value == 0
                          ? _offController.precent.value.text
                          : null,
                      "topPrice": _offController.selectedType.value == 0
                          ? _offController.top.value.text.replaceAll(",", "")
                          : null,
                      "discountPrice": _offController.selectedType.value == 0
                          ? null
                          : _offController.amount.value.text.replaceAll(",", ""),
                      "useForType":userType!= null ? userType: _offController.selectedCategory.value == 0
                          ? "public"
                          : "category",
                      "useForId":id !=null ? id: _offController.selectedCategory.value == 0
                          ? null
                          : _offController.selectedCategoryId.value,
                      "expireDate": _offController.endDate.value,
                      "startDate": _offController.startDate.value,
                      "code":_offController.code.value.text
                    };
                    MyAlert.loding();
                    await _offController.createOff(body);
                    Get.back();
                    if(_offController.failureMessageCreateOff.value !=""){
                      MyAlert.mySnakbarRed(text: _offController.failureMessageCreateOff.value);
                    }else{
                      Get.back();
                      MyAlert.mySnakbar(text: "کد تخفیف با موفقیت ایجاد شد");
                      if(userType == null){
                        _offController.allOffCode();
                      }
                    }
                  },
                  text: "ایجاد",
                  borderRadios: 10,
                  fontWeight: FontWeight.w500,
                  height: 40,
                  width: Get.width*0.1,
                  fontSize: 14,

                  textColor: Colors.white,
                  bgColor: AppColors.blueSession,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonText(
                  borderRadios: 10,
                  onPressed: () {
                    Get.back();
                  },
                  text: "انصراف",
                  height: 40,
                  fontSize: 14,
                  width: 70,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.blueSession,
                  bgColor: Colors.white,
                  borderColor: AppColors.blueSession,
                  activeBorder: 1,
                ),
              ],
            ),
          )
,
        ],
      );
    },
  );
}

Widget leftColumn(List<dynamic> type, OffController _offController) {
  return Expanded(
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      selectedTypeOff(type, _offController),
    ]),
  );
}

Widget rightColumn(TextEditingController _title, List<dynamic> option,
    OffController _offController,{String? name}) {
  return Expanded(

    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      SizedBox(
        width: Get.width * 0.2,
        child: TitleTextFieldWidget(
          title: "عنوان تخفیف",
          editingController: _title,
        ),
      ),
      name !=null ?  SizedBox(
        width: Get.width * 0.2,
        child: TitleTextWidget(
          title: "نام و نام خانوادگی",
          hint: name,
        ),
      ):selectedCategory(option, _offController),
      name !=null ?  const SizedBox(height: 0,): Obx(
        () => _offController.selectedCategory.value == 0
            ? const SizedBox(
                height: 10,
              )
            : Container(
                width: Get.width * 0.2,
                decoration: BoxDecoration(
                    color: AppColors.greyBorder,
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  dropdownColor: AppColors.greyBorder,
                  isExpanded: true,
                  underline: const SizedBox(height: 0),
                  value: _offController.selectedCategoryId.value,
                  items: _offController.resultCategory.value.data!.map((value) {
                    return DropdownMenuItem(
                      value: value.id,
                      child: ListTile(
                        title: CustomText(title: value.title),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    _offController.selectedCategoryId.value = val.toString();
                  },
                ),
              ),
      ),
      Obx(() => DatePikerWidget(
            title: "تاریخ شروع",
            from: 1,
            date: _offController.startDate.value,
          ),),
      const SizedBox(
        height: 10,
      ),
      Obx(() => DatePikerWidget(
            title: "تاریخ پایان",
            from: 20,
            date: _offController.endDate.value,
          ),),
      const SizedBox(
        width: 10,
      ),
    ]),
  );
}

Widget selectedCategory(List<dynamic> option, OffController _offController) {
 
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: CustomText(
          title: "انتخاب دسته بندی",
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      ListView.builder(
          itemCount: option.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _offController.selectedCategory.value = index;
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _offController.selectedCategory.value == index
                                      ? AppColors.darkerGreen
                                      : Colors.white,
                              border: Border.all(color: Colors.black)),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        CustomText(
                          title: option[index],
                        )
                      ],
                    ),
                  ),
                ));
          }),
    ],
  );
}

Widget selectedTypeOff(List<dynamic> list, OffController _offController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: CustomText(
          title: "انتخاب نوع تخفیف",
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Obx(() => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _offController.selectedType.value = index;
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _offController.selectedType.value == index
                                  ? AppColors.darkerGreen
                                  : Colors.white,
                              border: Border.all(color: Colors.black)),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        CustomText(
                          title: list[index],
                        )
                      ],
                    ),
                  ),
                ));
          }),
      const SizedBox(
        height: 10,
      ),
      Obx(() => _offController.selectedType.value == 0
          ? Column(
              children: [
                SizedBox(
                  width: Get.width * 0.2,
                  child: TitleTextFieldWidget(
                    title: "در صد تخفیف",
                    textInputType: TextInputType.number,
                    editingController: _offController.precent.value,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: Get.width * 0.2,
                  child: TitleTextFieldWidget(
                    title: "سقف تخفیف",
                    textInputType: TextInputType.number,
                    format: true,
                    editingController: _offController.top.value,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  width: Get.width * 0.2,
                  child: TitleTextFieldWidget(
                    title: "مبلغ",
                    format: true,
                    textInputType: TextInputType.number,
                    editingController: _offController.amount.value,
                  ),
                ),
              ],
            )),

      SizedBox(
        width: Get.width * 0.2,
        child: TitleTextFieldWidget(
          title: "کد",
          editingController: _offController.code.value,
        ),
      ),
      const SizedBox(height: 10),
      ButtonText(
        onPressed: (){

            var r = Random();
            const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
            _offController.code.value.text= List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();


        },
        text: "تولید کد تخفیف",
        height: 30,
        fontSize: 14,
        width: Get.width * 0.1,
        textColor: Colors.white,
        bgColor: AppColors.blue,
      ),
      const SizedBox(
        width: 10,
      ),


    ],
  );
}
