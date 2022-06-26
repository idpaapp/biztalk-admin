import 'package:biztalk_panel_admin/model/document/ducoment_model.dart';
import 'package:biztalk_panel_admin/model/edit/edit_model.dart';
import 'package:biztalk_panel_admin/model/get_option_model.dart';
import 'package:biztalk_panel_admin/service/document_repository.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController {
  final DocumentRepository _documentRepository = Get.find<DocumentRepository>();
  RxBool isActiveJobSwitch = false.obs;
  List<Map<String, String>> listPdfJobId = <Map<String, String>>[].obs;
  List<Map<String, String>> listPdfJobUrl = <Map<String, String>>[].obs;
  RxString companyName = "انتخاب کنید".obs;
  RxString companyId = "".obs;
  RxString companyIcon = "".obs;

  //******************************** get document
  RxString failureMessageGetDocument = "".obs;
  var resultGetDocument = DocumentsModel().obs;
  RxBool isLoadingGetDocument = false.obs;

  getDocument(String id) async {
    failureMessageGetDocument.value = "";
    isLoadingGetDocument.value = true;
    final result = await _documentRepository.getDocument(id);
    result.fold(
      (left) {
        failureMessageGetDocument.value = left.message;
      },
      (right) {
        resultGetDocument.value = right;
        isLoadingGetDocument.value = false;
      },
    );
  }

  //*-************* confirm additiosnal
  RxString failureMessageConfirmAdditional = "".obs;
  var resultConfirmAdditional = EditModel().obs;
  RxBool isLoadingConfirmAdditional = false.obs;

  RxBool activeSetNameOrgan = false.obs;
  RxBool isSearch = false.obs;
  RxList filterSearch = [].obs;

  RxString selectedEducationId = "".obs;
  RxString selectedEducationImage = "".obs;
  RxString selectedEducationTitle = "انتخاب کنید".obs;
  RxBool isActiveEducationSwitch = false.obs;
  RxBool isManualTitleUniverCity = false.obs;

  confirmAdditional(String id, Map<String, dynamic> body) async {
    failureMessageConfirmAdditional.value = "";
    isLoadingConfirmAdditional.value = true;
    final result = await _documentRepository.confirmAdditional(id, body);
    result.fold(
      (left) {
        failureMessageConfirmAdditional.value = left.message;
      },
      (right) {
        resultConfirmAdditional.value = right;
        isLoadingConfirmAdditional.value = false;
      },
    );
  }

  //************************
  //******************************** get option
  RxString failureMessageGetOption = "".obs;

  RxBool isLoadingGetOption = false.obs;
  var resultGetOption = GetOptionModel().obs;

  getOption(String type) async {
    failureMessageGetOption.value = "";
    isLoadingGetOption.value = true;
    final result = await _documentRepository.getOption(type);
    result.fold(
      (left) {
        failureMessageGetOption.value = left.message;
      },
      (right) {
        resultGetOption.value = right;
        isLoadingGetOption.value = false;
      },
    );
  }

  //******************************* create job

  RxString failureMessageCreateJob = "".obs;
  RxBool isLoadingCreateJob = false.obs;
  var resultCreateJob = EditModel().obs;

  createJob(Map<String, dynamic> body, String id) async {
    failureMessageCreateJob.value = "";
    isLoadingCreateJob.value = true;
    final result = await _documentRepository.createWorkExperience(body, id);
    result.fold(
      (left) {
        failureMessageCreateJob.value = left.message;
      },
      (right) {
        resultCreateJob.value = right;
        isLoadingCreateJob.value = false;
      },
    );
  }

  //******************************* edit education
  RxString failureMessageEditJob = "".obs;
  RxBool isLoadingEditJob = false.obs;
  var resultEditJob = EditModel().obs;

  editJob(Map<String, dynamic> body, String id, String itemId) async {
    failureMessageEditJob.value = "";
    isLoadingEditJob.value = true;
    final result =
        await _documentRepository.editWorkExperience(body, id, itemId);
    result.fold(
      (left) {
        failureMessageEditJob.value = left.message;
      },
      (right) {
        resultEditJob.value = right;
        isLoadingEditJob.value = false;
      },
    );
  }
  //**************** delete job

  RxString failureMessageDeleteJob = "".obs;
  RxBool isLoadingDeleteJob = false.obs;
  var resultDeleteJob = EditModel().obs;

  deleteJob( String id, String itemId) async {
    failureMessageDeleteJob.value = "";
    isLoadingDeleteJob.value = true;
    final result =
        await _documentRepository.deleteWorkExperience(id, itemId);
    result.fold(
      (left) {
        failureMessageDeleteJob.value = left.message;
      },
      (right) {
        resultDeleteJob.value = right;
        isLoadingDeleteJob.value = false;
      },
    );
  } //**************** delete education

  RxString failureMessageDeleteEducation = "".obs;
  RxBool isLoadingDeleteEducation = false.obs;
  var resultDeleteEducation = EditModel().obs;

  deleteEducation( String id, String itemId) async {
    failureMessageDeleteEducation.value = "";
    isLoadingDeleteEducation.value = true;
    final result =
        await _documentRepository.deleteEducation(id, itemId);
    result.fold(
      (left) {
        failureMessageDeleteEducation.value = left.message;
      },
      (right) {
        resultDeleteEducation.value = right;
        isLoadingDeleteEducation.value = false;
      },
    );
  }
  //********************************************* edot education

  RxString failureMessageEditEducation = "".obs;
  RxBool isLoadingEditEducation = false.obs;
  var resultEditEducation = EditModel().obs;

  editEducation(Map<String, dynamic> body, String id, String itemId) async {
    failureMessageEditEducation.value = "";
    isLoadingEditEducation.value = true;
    final result =
    await _documentRepository.editEducation(body, id, itemId);
    result.fold(
          (left) {
            failureMessageEditEducation.value = left.message;
      },
          (right) {
            resultEditEducation.value = right;
        isLoadingEditEducation.value = false;
      },
    );
  }
  //********************* delete achivement

  RxString failureMessageDeleteAchievement = "".obs;
  RxBool isLoadingDeleteAchievement = false.obs;
  var resultDeleteAchievement = EditModel().obs;

  deleteAchievement( String id, String itemId) async {
    failureMessageDeleteAchievement.value = "";
    isLoadingDeleteAchievement.value = true;
    final result =
    await _documentRepository.deleteAchievement(id, itemId);
    result.fold(
          (left) {
            failureMessageDeleteAchievement.value = left.message;
      },
          (right) {
            resultDeleteAchievement.value = right;
        isLoadingDeleteAchievement.value = false;
      },
    );
  }
  //********************* edit achivement



  RxString failureMessageEditAchivement = "".obs;
  RxBool isLoadingEditAchivement = false.obs;
  var resultEditAchivement = EditModel().obs;

  editAchivement(Map<String, dynamic> body, String id, String itemId) async {
    failureMessageEditAchivement.value = "";
    isLoadingEditAchivement.value = true;
    final result =
    await _documentRepository.editAchive(body, id, itemId);
    result.fold(
          (left) {
            failureMessageEditAchivement.value = left.message;
      },
          (right) {
            resultEditAchivement.value = right;
        isLoadingEditAchivement.value = false;
      },
    );
  }


  //******************************* create education

  RxString failureMessageCreateEducation = "".obs;
  RxBool isLoadingCreateEducation = false.obs;
  var resultCreateEducation = EditModel().obs;

  createEducation(Map<String, dynamic> body, String id) async {
    failureMessageCreateEducation.value = "";
    isLoadingCreateEducation.value = true;
    final result = await _documentRepository.createEducation(body, id);
    result.fold(
      (left) {
        failureMessageCreateEducation.value = left.message;
      },
      (right) {
        resultCreateEducation.value = right;
        isLoadingCreateEducation.value = false;
      },
    );
  }

  //*****************************
  RxString failureMessageCreateAchive = "".obs;
  RxBool isLoadingCreateAchive = false.obs;
  var resultCreateAchive = EditModel().obs;

  createAchive(Map<String, dynamic> body, String id) async {
    failureMessageCreateAchive.value = "";
    isLoadingCreateAchive.value = true;
    final result = await _documentRepository.createAchive(body, id);
    result.fold(
      (left) {
        failureMessageCreateAchive.value = left.message;
      },
      (right) {
        resultCreateAchive.value = right;
        isLoadingCreateAchive.value = false;
      },
    );
  }
}
