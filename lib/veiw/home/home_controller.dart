import 'dart:async';
import 'package:biztalk_panel_admin/model/category/category_model.dart';
import 'package:biztalk_panel_admin/model/contact/all_contact_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/home/check_list_model.dart';
import 'package:biztalk_panel_admin/model/home/info_home_model.dart';
import 'package:biztalk_panel_admin/model/home/report_list_model.dart';
import 'package:biztalk_panel_admin/model/home/request_list_model.dart';
import 'package:biztalk_panel_admin/model/home/session_list_model.dart';
import 'package:biztalk_panel_admin/model/home/single_report_model.dart';
import 'package:biztalk_panel_admin/model/home/tv_list_model.dart';
import 'package:biztalk_panel_admin/model/home/user_home_model.dart';
import 'package:biztalk_panel_admin/model/transaction/not_verify_account_model.dart';
import 'package:biztalk_panel_admin/model/tv/all_tvs_model.dart';
import 'package:biztalk_panel_admin/service/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedHomeTab = 0.obs;
  RxInt selectedPage = 1.obs;
  final HomeRepository _homeRepo = Get.find<HomeRepository>();
  RxBool showMoreRegion = false.obs;

  RxInt tab = 0.obs;
  RxString failureMessageChangeStatus = "".obs;
  RxBool isLoadingChangeStatus = false.obs;
  var resultChangeStatus = EditModel().obs;

  changeStatus(String id,String status) async {
    failureMessageChangeStatus.value = "";
    isLoadingChangeStatus.value = true;
    final result = await _homeRepo.changeUserStatus(id, status);
    result.fold(
          (left) {
        failureMessageChangeStatus.value = left.message;
      },
          (right) {
        resultChangeStatus.value = right;
        isLoadingChangeStatus.value = false;
      },
    );
  }

//******************* fetch home data

  RxString failureMessageFetchHome = "".obs;
  var resultFetchHome = HomeInfoModel().obs;
  RxBool isLoadingFetchHome = false.obs;

  fetchInfoHome() async {
    failureMessageFetchHome.value = "";
    isLoadingFetchHome.value = true;
    final result = await _homeRepo.getInfoHome();
    result.fold(
      (left) {
        failureMessageFetchHome.value = left.message;
      },
      (right) {
        resultFetchHome.value = right;
        isLoadingFetchHome.value = false;
      },
    );
  }

//************************ fetch user
  RxList <User>selectedMentor=<User>[].obs;
  RxList<User> selectedMentorFinaly=<User>[].obs;

  RxString failureMessage = "".obs;
  var resultHomeUsers = UsersHomeModel().obs;
  RxBool isLoadingHome = false.obs;

 fetchUsers(int page, {String? mobile,String? status,String ? type}) async {
    failureMessage.value = "";
    isLoadingHome.value = true;
    final result = await _homeRepo.getUserHome(page: page, mobile: mobile,status: status,type: type);
    result.fold(
      (left) {
        failureMessage.value = left.message;
      },
      (right) {
        resultHomeUsers.value = right;
        isLoadingHome.value = false;
      },
    );
  }

  //************************** get categoury

  RxString failureMessageCategory = "".obs;
  var resultCategory = CategoryModel().obs;
  RxBool isLoadingCategory = false.obs;

  Future<void> fetchCategory() async {
    failureMessageCategory.value = "";
    isLoadingCategory.value = true;
    final result = await _homeRepo.getCategory();
    result.fold(
      (left) {
        failureMessageCategory.value = left.message;
      },
      (right) {
        resultCategory.value = right;
        isLoadingCategory.value = false;
      },
    );
  }

  //************* get tv
  RxString failureMessageAllTvs = "".obs;
  var resultAllTvs = AllTvsModel().obs;
  RxBool isLoadingAllTvs = false.obs;

  fetchTvs() async {
    failureMessageAllTvs.value = "";
    isLoadingAllTvs.value = true;
    final result = await _homeRepo.getAllTvs();
    result.fold(
      (left) {
        failureMessageAllTvs.value = left.message;
      },
      (right) {
        resultAllTvs.value = right;
        isLoadingAllTvs.value = false;
      },
    );
  }

  //****************** get contact
  RxString failureMessageAllContact = "".obs;
  var resultAllContact = AllContactModel().obs;
  RxBool isLoadingAllContact = false.obs;

  fetchContact() async {
    failureMessageAllContact.value = "";
    isLoadingAllContact.value = true;
    final result = await _homeRepo.getAllContact();
    result.fold(
      (left) {
        failureMessageAllContact.value = left.message;
      },
      (right) {
        resultAllContact.value = right;
        isLoadingAllContact.value = false;
      },
    );
  }

  //********************** get Not verify Account
  RxString failureMessageNotVerify = "".obs;
  var resultNotVerify = NotVerifyAccountModel().obs;
  RxBool isLoadingNotVerify = false.obs;

  notVerify(int page) async {
    failureMessageNotVerify.value = "";
    isLoadingNotVerify.value = true;
    final result = await _homeRepo.getNotVerifyAccount(page);
    result.fold(
      (left) {
        failureMessageNotVerify.value = left.message;
      },
      (right) {
        resultNotVerify.value = right;
        isLoadingNotVerify.value = false;
      },
    );
  }

  //************************* verify account
  //********************** get Not verify Account
  RxString failureMessageVerifyAccount = "".obs;
  var resultVerifyAccount = EditModel().obs;
  RxBool isLoadingVerifyAccount = false.obs;

  VerifyAccount(String userId, bool confirm) async {
    failureMessageVerifyAccount.value = "";
    isLoadingVerifyAccount.value = true;
    final result = await _homeRepo.verifyAccount(userId, confirm);
    result.fold(
      (left) {
        failureMessageVerifyAccount.value = left.message;
      },
      (right) {
        resultVerifyAccount.value = right;
        isLoadingVerifyAccount.value = false;
      },
    );
  }

//********************* check list
  RxString failureMessageCheckList = "".obs;
  var resultCheckList = CheckListModel().obs;
  RxBool isLoadingCheckList = false.obs;

  checkList(int page) async {
    failureMessageCheckList.value = "";
    isLoadingCheckList.value = true;
    final result = await _homeRepo.getCheckList(page);
    result.fold(
      (left) {
        failureMessageCheckList.value = left.message;
      },
      (right) {
        resultCheckList.value = right;
        isLoadingCheckList.value = false;
      },
    );
  }

  //**************************** request list
  RxString failureMessageRequestList = "".obs;
  var resultRequestList = RequestListModel().obs;
  RxBool isLoadingRequestList = false.obs;

  requestList(int page) async {
    failureMessageRequestList.value = "";
    isLoadingRequestList.value = true;
    final result = await _homeRepo.requestList(page);
    result.fold(
      (left) {
        failureMessageRequestList.value = left.message;
      },
      (right) {
        resultRequestList.value = right;
        isLoadingRequestList.value = false;
      },
    );
  } //**************************** request list

  RxString failureMessageSessionList = "".obs;
  var resultSessionList = SessionListModel().obs;
  RxBool isLoadingSessionList = false.obs;

  sessionList(int page) async {
    failureMessageSessionList.value = "";
    isLoadingSessionList.value = true;
    final result = await _homeRepo.sessionList(page);
    result.fold(
      (left) {
        failureMessageSessionList.value = left.message;
      },
      (right) {
        resultSessionList.value = right;
        isLoadingSessionList.value = false;
      },
    );
  } //**************************** report list

  RxString failureMessageReportList = "".obs;
  var resultReportList = ReportListModel().obs;
  RxBool isLoadingReportList = false.obs;

  reportList(int page) async {
    failureMessageReportList.value = "";
    isLoadingReportList.value = true;
    final result = await _homeRepo.reportList(page);
    result.fold(
      (left) {
        failureMessageReportList.value = left.message;
      },
      (right) {
        resultReportList.value = right;
        isLoadingReportList.value = false;
      },
    );
  }

  //******************************* single report
  RxString failureMessageSingleReport = "".obs;
  var resultSingleReport = SingleReportModel().obs;
  RxBool isLoadingSingleReport = false.obs;

  singleReport(String id) async {
    failureMessageSingleReport.value = "";
    isLoadingSingleReport.value = true;
    final result = await _homeRepo.singleReport(id);
    result.fold(
      (left) {
        failureMessageSingleReport.value = left.message;
      },
      (right) {
        resultSingleReport.value = right;
        isLoadingSingleReport.value = false;
      },
    );
  }

  //*************************** get single session
  RxString failureMessageSingleSession = "".obs;
  var resultSingleSession = SingleReportModel().obs;
  RxBool isLoadingSingleSession = false.obs;

  singleSession(String id) async {
    failureMessageSingleSession.value = "";
    isLoadingSingleSession.value = true;
    final result = await _homeRepo.singleSession(id);
    result.fold(
      (left) {
        failureMessageSingleSession.value = left.message;
      },
      (right) {
        resultSingleSession.value = right;
        isLoadingSingleSession.value = false;
      },
    );
  }  //*************************** get single request
  RxString failureMessageSingleRequest = "".obs;
  var resultSingleRequest = SingleReportModel().obs;
  RxBool isLoadingSingleRequest = false.obs;

  singleRequest(String id) async {
    failureMessageSingleRequest.value = "";
    isLoadingSingleRequest.value = true;
    final result = await _homeRepo.singleRequest(id);
    result.fold(
      (left) {
        failureMessageSingleRequest.value = left.message;
      },
      (right) {
        resultSingleRequest.value = right;
        isLoadingSingleRequest.value = false;
      },
    );
  }

  //******************************** list tv
  RxString failureMessageListTv = "".obs;
  var resultListTv = TvListModel().obs;
  RxBool isLoadingListTv = false.obs;

  tvList(int page) async {
    failureMessageListTv.value = "";
    isLoadingListTv.value = true;
    final result = await _homeRepo.listTv(page);
    result.fold(
      (left) {
        failureMessageListTv.value = left.message;
      },
      (right) {
        resultListTv.value = right;
        isLoadingListTv.value = false;
      },
    );
  }

  //*********************************** confirm tv or contact
  RxString failureMessageConfirm = "".obs;
  var resultConfirm = EditModel().obs;
  RxBool isLoadingConfirm = false.obs;

  confirm(String userId, String type, String tvId) async {
    failureMessageConfirm.value = "";
    isLoadingConfirm.value = true;
    final result = await _homeRepo.confirmTvOrContact(userId, type, tvId);
    result.fold(
      (left) {
        failureMessageConfirm.value = left.message;
      },
      (right) {
        resultConfirm.value = right;
        isLoadingConfirm.value = false;
      },
    );
  }


  //*********************************** confirm tv or contact
  RxString failureMessageAddUser = "".obs;
  var resultAddUser = EditModel().obs;
  RxBool isLoadingAddUser = false.obs;

  addUser(Map<String,dynamic> body) async {
    failureMessageAddUser.value = "";
    isLoadingAddUser.value = true;
    final result = await _homeRepo.addUser(body);
    result.fold(
      (left) {
        failureMessageAddUser.value = left.message;
      },
      (right) {
        resultAddUser.value = right;
        isLoadingAddUser.value = false;
      },
    );
  }

  Timer? timer;

  @override
  void onInit() {
    fetchInfoHome();

    timer = Timer.periodic(
        const Duration(minutes: 5), (Timer t) => fetchInfoHome());

    tab.value = 0;
    fetchUsers(1);
    fetchCategory();

    fetchContact();

    fetchTvs();
    super.onInit();
  }
}
