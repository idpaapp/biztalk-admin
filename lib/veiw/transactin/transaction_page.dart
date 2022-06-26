import 'package:biztalk_panel_admin/resources/app_colors.dart';
import 'package:biztalk_panel_admin/resources/custom_text.dart';
import 'package:biztalk_panel_admin/veiw/home/widget/top_section_panel_admin.dart';
import 'package:biztalk_panel_admin/veiw/single_mentor/widgets/profile_section_widget.dart';
import 'package:biztalk_panel_admin/veiw/transactin/transaction_controller.dart';
import 'package:biztalk_panel_admin/veiw/transactin/widgets/container_transaction_profile_widget.dart';
import 'package:biztalk_panel_admin/veiw/transactin/widgets/transaction_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionPage extends StatelessWidget {
  static const route = "/transactionPage";

  late String image;
  late String id;
  late String fullName;
  late String jobTitle;
  late String typeUser;
  final TransactionController _transactionController =
      Get.put(TransactionController());

  TransactionPage({Key? key}) : super(key: key) {

    image = Get.arguments['image'];
    id = Get.arguments['id'];
    fullName = Get.arguments['fullName'];
    jobTitle = Get.arguments['jobTitle'];
    typeUser = Get.arguments['typeUser'];


    _transactionController.fetchTransaction(id, 1);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AppColors.veryLightGrey,
        body: Obx(() {
          if (_transactionController.failureMessage.value != "") {
            return Center(
              child: CustomText(
                  title: _transactionController.failureMessage.value),
            );
          } else if (_transactionController.isLoadingTransaction.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return getBody();
          }
        }),
      );

  Widget getBody() => SingleChildScrollView(
    child: Column(
          children: [
            const TopSectionPanelAdmin(title: "گردش حساب"),
            SizedBox(
              height: Get.height * 0.07,
            ),
            ProfileSectionWidget(
              isTransaction: true,
              isUser: typeUser == "user" ? true : false,
              image: image,
              onEdit: () {},
              fullName: fullName,
              jobTitle: jobTitle,
              widget: Row(
                children: [
                  ContainerTransactionProfileWidget(
                    title: "درخواست تسویه حساب",
                    bgColor: AppColors.orange,
                    amount: _transactionController.resultTransaction.value.data!
                            .checkOutInfo!.amountFormat ??
                        "0",
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  ContainerTransactionProfileWidget(
                      amount: _transactionController.resultTransaction.value.data!
                              .walletInfo!.formattedBalance ??
                          "0",
                      bgColor: AppColors.green,
                      title: "موجودی کیف پول"),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.07,
            ),
            mainSection(),
            const SizedBox(
              height: 10,
            )
          ],
        ),
  );

  mainSection() => Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.02, vertical: Get.height * 0.02),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CustomText(
            title: "تراکنش ها",
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.lighterBlack,
          ),
          const SizedBox(
            height: 20,
          ),
          const TransactionTitleTableWidget(
            isTitle: true,
            amount: "مبلغ(تومان)",
            date: "تاریخ تراکنش",
            type: "نوع تراکنش",
            amountColor: AppColors.black,
            stateTitle: "وضعیت",
            state: null,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _transactionController
                  .resultTransaction.value.data!.transData!.trans!.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                var tran = _transactionController
                    .resultTransaction.value.data!.transData!.trans![index];
                return TransactionTitleTableWidget(
                  isTitle: false,
                  amount: tran.amountFormat,
                  date: tran.transactionDate,
                  type: tran.typeTitle,
                  amountColor: AppColors.darkerGreen,
                  stateTitle: tran.statusTitle,
                  state: tran.status,
                );
              }),
          const SizedBox(
            height: 20,
          ),
          pageSection()
        ]),
      );

  Widget pageSection() {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _transactionController
                      .resultTransaction.value.data!.transData!.totalPages! <=
                  5
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
              itemCount: _transactionController
                  .resultTransaction.value.data!.transData!.totalPages,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(
                  () => InkWell(
                    onTap: () {
                      _transactionController.fetchTransaction(id, index + 1);
                      _transactionController.selectedPage.value = index + 1;
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index + 1 ==
                                  _transactionController.selectedPage.value
                              ? AppColors.blueIndigo
                              : Colors.white),
                      child: Center(
                        child: CustomText(
                          title: "${index + 1}",
                          color: index + 1 ==
                                  _transactionController.selectedPage.value
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
          _transactionController
                      .resultTransaction.value.data!.transData!.totalPages! <=
                  5
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
