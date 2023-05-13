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
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../export.dart';

class CreateAccountController extends GetxController {
  TextEditingController? confirmTextController;
  TextEditingController? passwordTextController;
  TextEditingController? nameTextController;
  TextEditingController? identificationTextController;
  TextEditingController? mobileTextController;
  TextEditingController? addressTextController;
  TextEditingController? medicalConditionTextController;
  TextEditingController? dobTextController;
  TextEditingController? emailTextController;
  TextEditingController? zipTextController;
  TextEditingController? genderTextController;
  FocusNode? confirmFocusNode;
  FocusNode? zipFocusNode;
  FocusNode? nameFocusNode;
  FocusNode? identificationFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? medicalConditionFocusNode;
  FocusNode? dobFocusNode;
  FocusNode? genderFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  LoginDataModel? loginData = LoginDataModel();
  var countryCode;
  var contactNo;
  var fileName, extension;
  String? formatted;
  File? documentFile;
  int? sizeInBytes;
  double? sizeInMb;
  bool isHide = false;
  bool isConHide = false;
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
    if (Get.arguments != null) {
      contactNo = Get.arguments[contactIdKey];
      debugPrint('mobile number ${contactNo.toString()}');
    }
    initEditTextController();
    getProfileData();
    super.onInit();
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
    debugPrint("fileName${fileName}");
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
        flashBar(message: strFileMaxLimit);
      } else {
        documentFile = File(
          result.files.single.path.toString(),
        );
        fileName = result.files.single.path.toString().split('/').last;
        update();
      }
    } else {
      flashBar(message: strFilePickedCancelled);
    }
  }

  getProfileData() async {
    _preferenceManger.getSavedLoginData().then((value) {
      if (value != null) {
        loginData = value;
        mobileTextController?.text = "+60-" + loginData!.contactNo;
      }
    });
  }

  /*===================================================- On device back press======================================================*/

  Future<bool> onWillPop() {
    debugPrint(backPressCounter.toString());
    if (backPressCounter < 1) {
      flashBar(message: strBackPressMessage);
      backPressCounter++;
      Future.delayed(Duration(milliseconds: 1500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      if (GetPlatform.isAndroid) {
        SystemNavigator.pop();
      }
      return Future.value(true);
    }
  }

  /* =========================================================init all edit text, focus node, models that are used in this controller ============================================*/

  initEditTextController() {
    confirmTextController = TextEditingController();
    passwordTextController = TextEditingController();
    nameTextController = TextEditingController();
    zipTextController = TextEditingController();
    genderTextController = TextEditingController();
    identificationTextController = TextEditingController();
    mobileTextController = TextEditingController();
    addressTextController = TextEditingController();
    medicalConditionTextController = TextEditingController();
    dobTextController = TextEditingController();
    emailTextController = TextEditingController();
    update();
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoHomeScreen() {
    Get.toNamed(AppRoutes.mainScreen);
    clearEditText();
  }

  /* =======================================================clearEditText===========================================*/

  clearEditText() {
    confirmTextController?.clear();
    passwordTextController?.clear();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitCreateAccountApi() async {
    dio.MultipartFile? files;
    if (documentFile != null && documentFile != '') {
      files = await dio.MultipartFile.fromFile(documentFile?.path ?? "",
          filename: documentFile?.path.split("/").last);
    }

    Map<String, dynamic> requestModel =
        AuthRequestModel.createAccountRequestModel(
      email: emailTextController?.text.trim(),
      files: files,
      zipCode: zipTextController?.text.trim(),
      password: passwordTextController?.text.trim(),
      address: addressTextController?.text.trim(),
      description: medicalConditionTextController?.text.trim(),
      dob: formatted,
      gender: genderId,
      IdentityNumber: identificationTextController?.text.trim(),
      name: nameTextController?.text.trim(),
      deviceName: _repository.deviceName ?? "",
      deviceType: _repository.deviceType,
      deviceToken: await FirebaseMessaging.instance.getToken(),
    );
    _repository
        .createAccountApiCall(dataBody: requestModel, contactNo: contactNo)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        flashBar(message: '${loginResponseModel?.message.toString()}');
        gotoHomeScreen();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveAuthToken(loginResponseModel?.accessToken ?? "");
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  @override
  void dispose() {
    clearEditText();
    super.dispose();
  }
}

class AreaType {
  int id;
  String type;

  AreaType({required this.id, required this.type});
}
