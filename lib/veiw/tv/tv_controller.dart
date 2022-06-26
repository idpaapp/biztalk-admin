import 'package:biztalk_panel_admin/model/contact/mentor_contact_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/tv/mentor_tv_model.dart';
import 'package:biztalk_panel_admin/service/mentor_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TvController extends GetxController {
  @override
  void onClose() {
    tvAddress.close();
    contactAddress.close();
    // TODO: implement onClose
    super.onClose();
  }

  //********************** tv
  RxBool isActiveTvSwitch = false.obs;
  RxString tvTitle = "".obs;
  RxString tvId = "".obs;
  RxString tvImage = "".obs;
  var tvAddress = TextEditingController().obs;

  //************************* contact
  RxString contactTitle = "".obs;
  RxString contactId = "".obs;
  RxString contactImage = "".obs;
  var contactAddress = TextEditingController().obs;

  //************************
  final MentorRepository _repository = Get.find<MentorRepository>();

  Stream<Widget> fetchMentorTv({
    required String id,
    required Widget Function() onLoading,
    required Widget Function(String) onFailure,
    required Widget Function(MentorTvsModel?) onSuccess,
  }) async* {
    yield onLoading();

    final result = await _repository.getMentorTvs(id);
    yield result.fold(
      (left) => onFailure(left.message),
      (right) => onSuccess(right),
    );
  }

  Stream<Widget> fetchMentorContact({
    required String id,
    required Widget Function() onLoading,
    required Widget Function(String) onFailure,
    required Widget Function(MentorContactModel?) onSuccess,
  }) async* {
    yield onLoading();

    final result = await _repository.getMentorContacts(id);
    yield result.fold(
      (left) => onFailure(left.message),
      (right) => onSuccess(right),
    );
  }

  //*************************** update tv

  //*************************** update tv
  RxString failureMessageUpdateTv = "".obs;
  var resultUpdateTv = EditModel().obs;
  RxBool isLoadingUpdateTv = false.obs;

  updateTv(Map<String, dynamic> body, String userId) async {
    isLoadingUpdateTv.value = true;
    final result = await _repository.updateTv(body, userId);
    result.fold(
      (left) {
        failureMessageUpdateTv.value = left.message;
      },
      (right) {
        resultUpdateTv.value = right;
        isLoadingUpdateTv.value = false;
      },
    );
  }

  //*************************** update contact
  RxString failureMessageUpdateContact = "".obs;
  var resultUpdateContact = EditModel().obs;
  RxBool isLoadingUpdateContact = false.obs;

  updateContact(Map<String, dynamic> body, String userId) async {
    isLoadingUpdateContact.value = true;
    final result = await _repository.updateContact(body, userId);
    result.fold(
      (left) {
        failureMessageUpdateContact.value = left.message;
      },
      (right) {
        resultUpdateContact.value = right;
        isLoadingUpdateContact.value = false;
      },
    );
  }

  //************************** create tv
  RxString failureMessageCreateTv = "".obs;
  var resultCreateTv = EditModel().obs;
  RxBool isLoadingCreateTv = false.obs;

  createTv(Map<String, dynamic> body, String userId) async {
    isLoadingCreateTv.value = true;
    final result = await _repository.createTv(body, userId);
    result.fold(
      (left) {
        failureMessageUpdateContact.value = left.message;
      },
      (right) {
        resultCreateTv.value = right;
        isLoadingCreateTv.value = false;
      },
    );
  }

  //************************** create contact
  RxString failureMessageCreateContact = "".obs;
  var resultCreateContact = EditModel().obs;
  RxBool isLoadingCreateContact = false.obs;

  createContact(Map<String, dynamic> body, String userId) async {
    isLoadingCreateContact.value = true;
    final result = await _repository.createContact(body, userId);
    result.fold(
      (left) {
        failureMessageCreateContact.value = left.message;
      },
      (right) {
        resultCreateContact.value = right;
        isLoadingCreateContact.value = false;
      },
    );
  }

  //************************** delete contact
  RxString failureMessageDeleteContact = "".obs;
  var resultDeleteContact = EditModel().obs;
  RxBool isLoadingDeleteContact = false.obs;

  deleteContact(Map<String, dynamic> body, String userId) async {
    isLoadingDeleteContact.value = true;
    final result = await _repository.deleteContact(body, userId);
    result.fold(
      (left) {
        failureMessageDeleteContact.value = left.message;
      },
      (right) {
        resultDeleteContact.value = right;
        isLoadingDeleteContact.value = false;
      },
    );
  }

  //****************** delete tv
  RxString failureMessageDeleteTv = "".obs;
  var resultDeleteTv = EditModel().obs;
  RxBool isLoadingDeleteTv = false.obs;

  deleteTv(Map<String, dynamic> body, String userId) async {
    isLoadingDeleteTv.value = true;
    final result = await _repository.deleteTv(body, userId);
    result.fold(
      (left) {
        failureMessageDeleteTv.value = left.message;
      },
      (right) {
        resultDeleteTv.value = right;
        isLoadingDeleteTv.value = false;
      },
    );
  }

  //********************** confirm tv or contact
  RxString failureMessageConfirm = "".obs;
  var resultConfirm = EditModel().obs;
  RxBool isLoadingConfirm = false.obs;

  confirmTvOrContact(Map<String, dynamic> body, String userId) async {
    isLoadingConfirm.value = true;
    final result = await _repository.confirmTvOrContact(body, userId);
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
}
