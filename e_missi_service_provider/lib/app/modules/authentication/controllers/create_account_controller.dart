/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';

import 'package:dio/dio.dart'as dio;
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../../export.dart';

class CreateAccountController extends GetxController {
  TextEditingController? confirmTextController;
  TextEditingController? nameTextController;
  TextEditingController? identificationTextController;
  TextEditingController? mobileTextController;
  TextEditingController? addressTextController;
  TextEditingController? workZoneController;
  TextEditingController? workExperienceController;
  TextEditingController? serviceSkilledTextController;
  TextEditingController? medicalConditionTextController;
  TextEditingController? dobTextController;
  TextEditingController? genderTextController;
  TextEditingController? emailTextController;
  TextEditingController? passwordTextController;

  FocusNode? confirmFocusNode;
  FocusNode? genderFocusNode;
  FocusNode? nameFocusNode;
  FocusNode? workZoneFocusNode;
  FocusNode? workExperienceFocusNode;
  FocusNode? identificationFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? serviceSkilledFocusNode;
  FocusNode? medicalConditionFocusNode;
  FocusNode? dobFocusNode;
  FocusNode? emailFocusNode;
  FocusNode? passwordFocusNode;
  String? formatted;
  List<LocationListDataModel> selectedLocation = [];
  List<String> commaSepratedLocationTitle = [];
  List<int> commaSepratedLocationId = [];
  List<dio.MultipartFile> filePath = [];

  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  var countryCode;
  bool isHide = true;
  bool isHide2 = true;
  var passwordData;

  List<AreaType> areTypeList = [
    AreaType(
      id: 1,
      type: "Petaling Jaya",
    ),
    AreaType(
      id: 2,
      type: "Subag Jaya",
    ),
    AreaType(
      id: 3,
      type: "Shah Alam",
    ),
    AreaType(
      id: 4,
      type: "Sharajah",
    ),
    AreaType(
      id: 5,
      type: "Puchang Jaya",
    ),
    AreaType(
      id: 6,
      type: "Petaling Jaya",
    ),
    AreaType(
      id: 7,
      type: "Subag Jaya",
    ),
    AreaType(
      id: 8,
      type: "Shah Alam",
    ),
    AreaType(
      id: 9,
      type: "Sharajah",
    ),
    AreaType(
      id: 10,
      type: "Puchang Jaya",
    ),
  ];
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

  var genderId;

  CategoryListResponse? categoryListResponse;
  LanguageResponseModel? languageResponseModel;
  SkillSetResponseModel? subCategoryListResponse;
  LocationListResponseModel? locationListResponseModel;
  List<LanguageDataModel>? languageList;
  List<LocationListDataModel>? locationList;
  List<CategoryDataModel>? categoryList;
  List<SkillDataModel>? subCategoryList;
  List<int>? joinVar = [];
  List<String>? selectedSubCategory = [];
  List<int>? selectedSubCategoryId = [];
  double? sizeInMb;
  var fileName, extension, extension2;
  File? documentFile;
  var fileName2;
  File? documentFile2;
  List docList=[];
  String? contactNo;

  var checkPass = false;

  @override
  void onInit() {
    initEditTextController();

    if (Get.arguments != null) {
      contactNo = Get.arguments[contactIdKey];
      mobileTextController!.text="+60-"+contactNo!;
    }
    super.onInit();
  }

  @override
  void onReady() {
    hitServiceCategoryAPI();
    languageAPI();
    hitLocationListAPI();
    super.onReady();
  }

  hitServiceCategoryAPI() {
    _repository.serviceCategoryApiCall().then((value) async {
      if (value != null) {
        categoryListResponse = value;
        categoryList = categoryListResponse!.list;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitLocationListAPI() {
    _repository.locationListApiCall().then((value) async {
      if (value != null) {
        locationListResponseModel = value;
        locationList = locationListResponseModel!.list;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  languageAPI() {
    _repository.languageApiCall().then((value) async {
      if (value != null) {
        languageResponseModel = value;
        languageList = languageResponseModel!.list;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitServiceSubCategoryAPI({catId}) {
    _repository
        .serviceSubCategoryApiCall(catId: catId.join(","))
        .then((value) async {
      if (value != null) {
        subCategoryListResponse = value;
        subCategoryList = subCategoryListResponse!.list;
        update();
      }
    }).onError((error, stackTrace) {});
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

  /* =========================================================  init all edit text, focus node, models that are used in this controller ============================================*/

  initEditTextController() {
    confirmTextController = TextEditingController();
    nameTextController = TextEditingController();
    identificationTextController = TextEditingController();
    mobileTextController = TextEditingController();
    addressTextController = TextEditingController();
    workZoneController = TextEditingController();
    workExperienceController = TextEditingController();
    serviceSkilledTextController = TextEditingController();
    medicalConditionTextController = TextEditingController();
    dobTextController = TextEditingController();
    genderTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();

    confirmFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    nameFocusNode = FocusNode();
    workZoneFocusNode = FocusNode();
    workExperienceFocusNode = FocusNode();
    identificationFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    serviceSkilledFocusNode = FocusNode();
    medicalConditionFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoOtpScreen() {
    Get.toNamed(AppRoutes.otpVerification, arguments: {
      contactIdKey: loginResponseModel?.detail?.contactNo ?? "",
      countryKey: loginResponseModel?.detail?.countryCode ?? "",
      emailIdKey: loginResponseModel?.detail?.email ?? "",
    });
    clearEditText();
  }

  /* =======================================================clearEditText===========================================*/

  clearEditText() {
    confirmTextController?.clear();
    passwordTextController?.clear();
  }

  /* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveAuthToken(loginResponseModel?.accessToken ?? "");
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  /* ======================================================hit Create account Api=========================================*/

  hitCreateAccountApi() async {
    filePath = [];
    if (docList.length != 0) {
      for (int i = 0; i < docList.length; i++) {
        await dio.MultipartFile.fromFile(docList[i],
            filename: docList[i]).then((value){
          filePath.add(value);
        });
      }
    }
        dio.MultipartFile? file2;
    if (documentFile2 != null && documentFile2 != '') {
      file2 = await dio.MultipartFile.fromFile(documentFile2!.path,
          filename: documentFile2!.path);
    }
    Map<String, dynamic> requestModel =
        AuthRequestModel.createAccountRequestData(
      fullName: nameTextController?.text.trim(),
      workZone: commaSepratedLocationId.join(','),
      identityNumber: identificationTextController?.text.trim(),
      gender: genderId,
      qualification: joinVar?.join(","),
      skill: selectedSubCategoryId?.join(","),
      experience: workExperienceController?.text.trim(),
      serviceLang: languageList
          ?.where((element) => element.isSelected == true)
          .toList()
          .map((e) => e.id)
          .join(","),
      email: emailTextController?.text.trim(),
      password: passwordTextController?.text.trim(),
      address: addressTextController?.text.trim(),
      dob: formatted,
      certificateImage: filePath,
      profileImage: file2,
          deviceName: _repository.deviceName ?? "",
          deviceType: _repository.deviceType,
          deviceToken: await FirebaseMessaging.instance.getToken(),
    );
    debugPrint("data ${requestModel}");
    _repository
        .createAccountApiCall(
            dataBody: requestModel, contactNo: contactNo?.replaceAll("-", ""))
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
      //   saveDataToLocalStorage(loginResponseModel);
        gotoHomeScreen();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoHomeScreen() {
    Get.offNamed(AppRoutes.subMissionRoute);
    clearEditText();
  }

  @override
  void dispose() {
    clearEditText();
    super.dispose();
  }
}

class QualificationData {
  String? title;
  bool? isSelected;

  QualificationData({this.title, this.isSelected});
}

class AreaType {
  int id;
  String type;

  AreaType({required this.id, required this.type});
}

class Animal {
  int id;
  String name;

  Animal({
    required this.id,
    required this.name,
  });
}
