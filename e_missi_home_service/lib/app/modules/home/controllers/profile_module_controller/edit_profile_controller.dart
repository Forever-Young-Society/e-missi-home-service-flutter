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
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../../export.dart';

class EditProfileController extends GetxController {
  TextEditingController? confirmTextController;
  TextEditingController? newPasswordTextController;
  TextEditingController? nameTextController;
  TextEditingController? identificationTextController;
  TextEditingController? mobileTextController;
  TextEditingController? zipTextController;
  TextEditingController? addressTextController;
  TextEditingController? medicalConditionTextController;
  TextEditingController? dobTextController;
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;
  TextEditingController? genderTextController;

  File? documentFile;
  var fileName, extension;
  double? sizeInMb;
  var edit = false;
  FocusNode? confirmFocusNode;
  FocusNode? nameFocusNode;
  FocusNode? zipFocusNode;
  FocusNode? identificationFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? medicalConditionFocusNode;
  FocusNode? dobFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  FocusNode? newPasswordFocusNode;
  FocusNode? genderFocusNode;

  bool isHide = false;
  String? formatted;

  bool isOldPassWord = false;
  bool isOldHide = false;
  bool isComHide = false;
  String? profileImageFile;
  bool isConfirmHide = false;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  var genderId;

  List<AreaType> genderList = [
    AreaType(
      id: 0,
      type: "Male",
    ),
    AreaType(
      id: 1,
      type: "Female",
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    hitprofileDetailApi();
    super.onReady();
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

  updateDocumentFilePDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf', 'png', "jpg"],
      type: FileType.custom,
    );
    if (result != null) {
      sizeInMb = (File(result.files.single.path.toString()).lengthSync() /
          (1024 * 1024));
      if (sizeInMb! > 10) {
        flashBar(message: 'File max limit exceed');
      } else {
        documentFile = File(
          result.files.single.path.toString(),
        );
        fileName = result.files.single.path.toString().split('/').last;
        update();
      }
    } else {
      flashBar(message: 'file not picked');
    }
  }

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImageFile = file.path;
      update();
    }
  }

  initEditTextController() {
    confirmTextController = TextEditingController();
    newPasswordTextController = TextEditingController();
    nameTextController =
        TextEditingController(text: loginResponseModel.detail?.fullName ?? '');
    identificationTextController = TextEditingController(
        text: loginResponseModel.detail?.identityNumber ?? '');
    mobileTextController = TextEditingController(
        text: "+60-" + loginResponseModel.detail?.contactNo ?? '');
    zipTextController =
        TextEditingController(text: loginResponseModel.detail?.zipcode ?? '');
    addressTextController =
        TextEditingController(text: loginResponseModel.detail?.address ?? '');
    medicalConditionTextController = TextEditingController(
        text: loginResponseModel.detail?.breifCondition ?? '');
    dobTextController = TextEditingController(
        text:
            "${DateFormat("dd MMMM yyyy").format(DateTime.parse(loginResponseModel.detail?.dateOfBirth))}");
    emailTextController =
        TextEditingController(text: loginResponseModel.detail?.email ?? '');
    passwordTextController = TextEditingController();
    genderTextController = TextEditingController(
        text: loginResponseModel.detail?.gender.toString() == "0"
            ? "Male"
            : "Female");
    genderId = loginResponseModel.detail?.gender;
    confirmFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    zipFocusNode = FocusNode();
    identificationFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    medicalConditionFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    newPasswordFocusNode = FocusNode();
    genderFocusNode = FocusNode();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitprofileDetailApi() {
    _repository.detailProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        initEditTextController();
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitUpdateAccountApi() async {
    dio.MultipartFile? profilePicture;
    if (profileImageFile != null && profileImageFile != '') {
      profilePicture = await dio.MultipartFile.fromFile(
          profileImageFile.toString(),
          filename: profileImageFile);
    }

    dio.MultipartFile? files;
    if (documentFile != null) {
      files = await dio.MultipartFile.fromFile(documentFile?.path ?? '',
          filename: documentFile?.path ?? '');
    }

    Map<String, dynamic> requestModel =
        AuthRequestModel.updateAccountRequestModel(
      email: emailTextController?.text.trim(),
      files: files,
      zipcode: zipTextController?.text.trim(),
      gender: genderId ?? 0,
      newPassword:
          isOldPassWord == true ? newPasswordTextController?.text.trim() : "",
      oldPassword:
          isOldPassWord == true ? passwordTextController?.text.trim() : "",
      profileFile: profilePicture,
      address: addressTextController?.text.trim(),
      description: medicalConditionTextController?.text.trim(),
      dob: formatted,
      IdentityNumber: identificationTextController?.text.trim(),
      name: nameTextController?.text.trim(),
    );
    _repository
        .updateProfileApiCall(dataBody: requestModel)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        edit = false;
        debugPrint('edit ${edit.toString()}');
        Get.back(result: true);
        flashBar(message: '${loginResponseModel.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  editTextClear() {
    confirmTextController!.clear();
    newPasswordTextController!.clear();
    nameTextController!.clear();
    identificationTextController!.clear();
    mobileTextController!.clear();
    zipTextController!.clear();
    addressTextController!.clear();
    medicalConditionTextController!.clear();
    dobTextController!.clear();
    emailTextController!.clear();
    passwordTextController!.clear();
  }
}
