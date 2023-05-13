import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/utils/helper_widget.dart';
import '../../../data/repository/api_repository.dart';
import '../../authentication/models/auth_request_model.dart';
import '../../home/model/dependent_detail_response_model.dart';

class SomeOneElseController extends GetxController {
  TextEditingController? nameTextController;
  TextEditingController? identificationTextController;
  TextEditingController? mobileTextController;
  TextEditingController? addressTextController;
  TextEditingController? ageTextController;
  TextEditingController? medicalConditionTextController;
  TextEditingController? dobTextController;
  TextEditingController? emailTextController;
  TextEditingController? zipTextController;
  FocusNode? zipFocusNode;
  FocusNode? nameFocusNode;
  FocusNode? identificationFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? ageFocusNode;
  FocusNode? medicalConditionFocusNode;
  FocusNode? dobFocusNode;
  FocusNode? emailFocusNode;
  final Repository _repository = Get.find<Repository>();
  DependentDetailResponseModel dependentDetailResponseModel =
      DependentDetailResponseModel();

  var isEdit;
  var edit = false;
  var fileName, extension;
  File? documentFile;
  int? sizeInBytes;
  double? sizeInMb;

  String? formatted;

  @override
  void onInit() {
    initEditText();
    super.onInit();
  }

  initEditText() {
    nameTextController = TextEditingController();
    identificationTextController = TextEditingController();
    mobileTextController = TextEditingController();
    addressTextController = TextEditingController();
    ageTextController = TextEditingController();
    medicalConditionTextController = TextEditingController();
    dobTextController = TextEditingController();
    emailTextController = TextEditingController();
    zipTextController = TextEditingController();

    zipFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    identificationFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    ageFocusNode = FocusNode();
    medicalConditionFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  hitAddDependentAccountApi() async {
    MultipartFile? files;
    if (documentFile != null && documentFile != '') {
      files = await MultipartFile.fromFile(documentFile?.path ?? '',
          filename: documentFile?.path ?? '');
    }

    Map<String, dynamic> requestModel =
        AuthRequestModel.addDependentAccountRequestModel(
      email: emailTextController?.text.trim(),
      files: files,
      zipCode: zipTextController?.text.trim(),
      IdentityNumber: identificationTextController?.text.trim(),
      mobile: mobileTextController?.text.trim(),
      address: addressTextController?.text.trim(),
      aboutMe: medicalConditionTextController?.text.trim(),
      dob: formatted,
      age: ageTextController?.text.trim(),
      name: nameTextController?.text.trim(),
    );
    _repository.addDependentApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        dependentDetailResponseModel = value;
        Get.back(result: true);
        flashBar(message: '${dependentDetailResponseModel.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  clearEditText() {
    ageTextController!.clear();
    nameTextController!.clear();
    zipTextController!.clear();
    identificationTextController!.clear();
    mobileTextController!.clear();
    addressTextController!.clear();
    medicalConditionTextController!.clear();
    dobTextController!.clear();
    emailTextController!.clear();
    documentFile = null;
    fileName = null;
    update();
    Get.back();
  }
}
