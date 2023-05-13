/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';

import 'package:dio/dio.dart' as dio;

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../export.dart';

class EditDependentController extends BaseController {
  TextEditingController? confirmTextController;

  TextEditingController? nameTextController;

  TextEditingController? ageTextController;
  TextEditingController? zipTextController;

  TextEditingController? identificationTextController;

  TextEditingController? mobileTextController;

  TextEditingController? addressTextController;

  TextEditingController? medicalConditionTextController;

  TextEditingController? dobTextController;

  TextEditingController? passwordTextController;

  TextEditingController? emailTextController;

  FocusNode? confirmFocusNode = FocusNode();
  FocusNode? nameFocusNode = FocusNode();
  FocusNode? identificationFocusNode = FocusNode();
  FocusNode? mobileFocusNode = FocusNode();
  FocusNode? addressFocusNode = FocusNode();
  FocusNode? zipFocusNode = FocusNode();
  FocusNode? medicalConditionFocusNode = FocusNode();
  FocusNode? dobFocusNode = FocusNode();
  FocusNode? ageFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();

  FocusNode? passwordFocusNode;
  String? formatted;

  var isEdit;
  var dependentId;
  var edit = false;
  var fileName, extension;
  File? documentFile;
  int? sizeInBytes;
  double? sizeInMb;
  String? profileImageFile;
  final Repository _repository = Get.find<Repository>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  DependentDetailResponseModel dependentDetailResponseModel =
      DependentDetailResponseModel();
  LoginDataModel loginData = LoginDataModel();
  FocusNode? genderFocusNode;
  TextEditingController? genderTextController;
  var genderId;

  List<AreaType> genderList = [
    AreaType(
      id: 0,
      type: strMale,
    ),
    AreaType(
      id: 1,
      type: strFeMale,
    ),
  ];

  @override
  void onInit() {
    if (Get.arguments != null) {
      dependentId = Get.arguments['id'];
      debugPrint(' dependentId ${dependentId}');
    }
    super.onInit();
  }

  @override
  void onReady() {
    hitDependentDetailApi(id: dependentId);
    super.onReady();
  }

  initEditTextField() {
    confirmTextController = TextEditingController();
    zipTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.zipcode.toString() ?? '');
    nameTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.fullName);
    ageTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.age.toString());
    identificationTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.identityNumber.toString() ??
            '');
    mobileTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.contactNo);
    addressTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.address);
    medicalConditionTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.aboutMe);
    dobTextController = TextEditingController(
        text:
            "${DateFormat("dd MMMM yyyy").format(DateTime.parse(dependentDetailResponseModel.detail?.dateOfBirth))}");
    passwordTextController = TextEditingController();
    emailTextController =
        TextEditingController(text: dependentDetailResponseModel.detail?.email);
    genderTextController = TextEditingController(
        text: dependentDetailResponseModel.detail?.gender == 0
            ? "Male"
            : "Female");
    debugPrint('Photo ${dependentDetailResponseModel.detail?.profileFile}');
    update();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitDependentDetailApi({id}) {
    _repository.detailDependentProfileApiCall(id: id).then((value) async {
      if (value != null) {
        dependentDetailResponseModel = value;
        update();
        initEditTextField();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ======================================================hitLoginApi=========================================*/

  hitRemoveDependentApi({id}) {
    _repository.removeDependentApiCall(id: id).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        Get.back(result: true);
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImageFile = file.path;
      update();
    }
  }

  updateDocumentFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      sizeInMb = (File(file.path).lengthSync() / (1024 * 1024));
      if (sizeInMb! > 10) {
        flashBar(message: strFileMaxLimit);
      } else {
        documentFile = documentFile = File(file.path);
        fileName = file.path.toString().split('/').last;
        update();
      }
    } else {
      flashBar(message: strFilePickedCancelled);
    }
  }

  hitUpdateDependentAccountApi({id}) async {
    dio.MultipartFile? files;
    if (documentFile != null && documentFile != '') {
      files = await dio.MultipartFile.fromFile(documentFile?.path ?? '',
          filename: documentFile?.path ?? '');
    }

    dio.MultipartFile? profilePicture;
    if (profileImageFile != null && profileImageFile != '') {
      profilePicture = await dio.MultipartFile.fromFile(
          profileImageFile.toString(),
          filename: profileImageFile);
    }
    debugPrint(
        "data of the report ${dependentDetailResponseModel.detail?.medicalReport.toString()}");
    Map<String, dynamic> requestModel =
        AuthRequestModel.addDependentAccountRequestModel(
      email: emailTextController?.text.trim(),
      // files:
      //     dependentDetailResponseModel.detail?.medicalReport == "" ? null : files,
      files: files,
      zipCode: zipTextController?.text.trim(),
      IdentityNumber: identificationTextController?.text.trim(),
      mobile: mobileTextController?.text.trim().replaceAll('-', ''),
      profileFile: profilePicture,
      address: addressTextController?.text.trim(),
      aboutMe: medicalConditionTextController?.text.trim(),
      dob: formatted,
      gender: genderId ?? 0,
      age: ageTextController?.text.trim(),
      name: nameTextController?.text.trim(),
    );
    _repository
        .updateDependentApiCall(dataBody: requestModel, id: id)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        Get.back(result: true);
        flashBar(message: '${loginResponseModel.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  clearEditText() {
    confirmTextController!.clear();
    zipTextController!.clear();
    ageTextController!.clear();
    nameTextController!.clear();
    identificationTextController!.clear();
    mobileTextController!.clear();
    addressTextController!.clear();
    medicalConditionTextController!.clear();
    dobTextController!.clear();
    passwordTextController!.clear();
    emailTextController!.clear();
    profileImageFile = null;
    documentFile = null;
    fileName = null;
    update();
    Get.back();
  }
}
