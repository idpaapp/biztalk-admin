// import 'package:biztalk_panel_admin/model/home/report_list_model.dart';
// import 'package:biztalk_panel_admin/service/home_repository.dart';
// import 'package:get/get.dart';
//
// class ReportListController extends GetxController{
//   RxInt selectedPage = 1.obs;
//   final HomeRepository _homeRepo = Get.find<HomeRepository>();
//   RxString  failureMessageReportList ="".obs;
//   var resultReportList = ReportListModel().obs;
//   RxBool isLoadingReportList = false.obs;
//
//   reportList(int page) async {
//     isLoadingReportList.value = true;
//     final result = await _homeRepo.reportList(page);
//     result.fold(
//           (left) {
//         failureMessageReportList.value = left.message;
//       },
//           (right) {
//         resultReportList.value = right;
//         isLoadingReportList.value=false;
//
//       },
//     );
//
//   }
//   @override
//   void onInit() {
//     selectedPage.value =1;
//     reportList(1);
//     // TODO: implement onInit
//     super.onInit();
//   }
// }