/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';
import 'package:dio/dio.dart' as Dio;
import 'package:e_missi_service_provider/export.dart' ;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class ProfileController extends BaseController
    with GetSingleTickerProviderStateMixin {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

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
  TextEditingController? oldPasswordTextController;
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
  FocusNode? oldPasswordFocusNode;
  List<Dio.MultipartFile> filePath = [];
  List<Dio.MultipartFile> filePathNew = [];

  bool isEdit = false;
  bool? isOldPassWord = false;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  var countryCode, docExtension;
  bool isHide = true;
  bool isHide2 = true;
  bool isHideOld = true;

  String? formatted;
  CategoryListResponse? categoryListResponse;
  LanguageResponseModel? languageResponseModel;
  SkillSetResponseModel? subCategoryListResponse;
  LocationListResponseModel? locationListResponseModel;
  List<LanguageDataModel>? languageList;
  List<CategoryDataModel>? categoryList;
  List<LocationListDataModel>? locationList = [];
  List<LocationListDataModel>? locationListShow = [];

  List<SkillDataModel>? subCategoryList;
  List<int>? joinVar = [];
  List<String>? selectedCategory = [];
  List<LocationListDataModel> selectedLocation = [];
  List<String> commaSepratedLocationTitle = [];
  List<int> commaSepratedLocationId = [];
  List<String>? selectedSubCategory = [];
  List<int>? selectedSubCategoryId = [];
  double? sizeInMb;
  double? sizeInMbNew;
  var fileName, extension, extension2;
  File? documentFile;
  File? documentFileNew;
  var fileNameNew, extensionNew, extension2New;
  var fileName2;
  String? documentFile2;
  List docList = [];

  var contactNo;
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

  ScrollController? scrollController;
  AnimationController? _controller;
  Animation<Color?>? colorState;
  Animation<Color?>? colorState2;
  bool isNotified = false;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    scrollController = ScrollController();
    hitprofileDetailApi();
    super.onReady();
  }

  _scrollToIndex() {
    scrollController?.animateTo(Get.height * 1.5,
        duration: const Duration(seconds: 2), curve: Curves.easeIn);
  }

  colorEffectMethod() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    // color tween
    colorState = ColorTween(begin: redColor, end: Colors.transparent)
        .animate(_controller!);
  }
  colorEffectMethodNull() {
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    // color tween
    colorState2 = ColorTween(begin: Colors.transparent, end: Colors.transparent)
        .animate(_controller!);
  }

  hitServiceCategoryAPI({isUpdate}) {
    _repository.serviceCategoryApiCall(isLoading: false).then((value) async {
      if (value != null) {
        categoryListResponse = value;
        categoryList = categoryListResponse!.list;
        selectedCategory =
            loginResponseModel?.detail?.qualifications.toString().split(",");
        if (categoryList!.isNotEmpty) {
          for (var i = 0; i < categoryList!.length; i++) {
            if (loginResponseModel?.detail?.qualifications
                    .toString()
                    .contains(categoryList![i].id.toString()) ==
                true) {
              categoryList?[i].isSelected = true;
              hitServiceSubCategoryAPI(
                  catId: selectedCategory, Isupdate: isUpdate);
            } else {
              categoryList?[i].isSelected = false;
            }
          }
        }
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
        if (locationList!.isNotEmpty) {
          List<String> address = [];
          for (var i = 0; i < locationList!.length; i++) {
            if (loginResponseModel?.detail?.workZone
                    .toString()
                    .contains(locationList![i].id.toString()) ==
                true) {
              address.add(locationList![i].title);
              locationList![i].isSelected = true;
              workZoneController?.text = address.join(', ');
            }
          }
        }
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

        if (languageList!.isNotEmpty) {
          for (var i = 0; i < languageList!.length; i++) {
            if (loginResponseModel?.detail?.languages
                    .toString()
                    .contains(languageList![i].id.toString()) ==
                true) {
              languageList?[i].isSelected = true;
            } else {
              languageList?[i].isSelected = false;
            }
          }
        }
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitServiceSubCategoryAPI({catId, Isupdate}) {
    _repository
        .serviceSubCategoryApiCall(catId: catId.join(","))
        .then((value) async {
      if (value != null) {
        subCategoryListResponse = value;
        subCategoryList = subCategoryListResponse!.list;
        if (subCategoryList!.isNotEmpty) {
          for (var i = 0; i < subCategoryList!.length; i++) {
            if (subCategoryList![i].subSkills != null &&
                subCategoryList![i].subSkills!.length != 0) {
              for (int j = 0; j < subCategoryList![i].subSkills!.length; j++) {
                if (loginResponseModel?.detail?.skills.toString().contains(
                        subCategoryList![i].subSkills![j].id.toString()) ==
                    true) {
                  subCategoryList![i].subSkills![j].isSelected = true;
                  if (Isupdate == null) {
                    selectedSubCategory
                        ?.add(subCategoryList![i].subSkills![j].title ?? "");
                  }

                  selectedSubCategoryId
                      ?.add(subCategoryList![i].subSkills![j].id ?? "");
                }
              }
            } else {
              if (loginResponseModel?.detail?.skills
                      .toString()
                      .contains(subCategoryList![i].id.toString()) ==
                  true) {
                subCategoryList?[i].isSelected = true;
                if (Isupdate == null) {
                  selectedSubCategory?.add(subCategoryList![i].title ?? "");
                }
                selectedSubCategoryId?.add(subCategoryList![i].id ?? "");
              } else {
                subCategoryList?[i].isSelected = false;
              }
            }
          }
          if (selectedSubCategory != null && selectedSubCategory!.length != 0) {
            serviceSkilledTextController?.text =
                selectedSubCategory?.join(",") ?? "";
          }
        }

        update();
      }
    }).onError((error, stackTrace) {});
  }

  hitprofileDetailApi({isUpdate}) {
    _repository.detailProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        docExtension = p.extension(
            loginResponseModel?.detail?.qualificationFile.toString() ?? "");
        initEditTextController();
        languageAPI();
        hitServiceCategoryAPI(isUpdate: isUpdate);
        hitLocationListAPI();

        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* =========================================================init all edit text, focus node, models that are used in this controller ============================================*/

  initEditTextController() {
    confirmTextController = TextEditingController();
    nameTextController =
        TextEditingController(text: loginResponseModel?.detail?.fullName ?? "");
    identificationTextController = TextEditingController(
        text: loginResponseModel?.detail?.identityNumber ?? "");
    mobileTextController = TextEditingController(
        text: loginResponseModel?.detail?.contactNo ?? "");
    addressTextController =
        TextEditingController(text: loginResponseModel?.detail?.address);
    workZoneController =
        TextEditingController(text: loginResponseModel?.detail?.workZone);
    workExperienceController = TextEditingController(
        text: loginResponseModel?.detail?.experience.toString() ?? "");
    serviceSkilledTextController = TextEditingController();
    medicalConditionTextController = TextEditingController();
    oldPasswordTextController = TextEditingController();
    dobTextController = TextEditingController(
        text:
            "${DateFormat("dd MMMM yyyy").format(DateTime.parse(loginResponseModel?.detail?.dateOfBirth ?? ''))}");

    genderTextController = TextEditingController(
        text: loginResponseModel?.detail?.gender == 0 ? "Male" : "Female");
    genderId = loginResponseModel?.detail?.gender;
    emailTextController =
        TextEditingController(text: loginResponseModel?.detail?.email ?? "");
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
    oldPasswordFocusNode = FocusNode();
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

  /* ======================================================hit Create account Api=========================================*/

  hitUpdateAccountApi() async {
    filePathNew = [];
    if (docList.length != 0) {
      for (int i = 0; i < docList.length; i++) {
        await Dio.MultipartFile.fromFile(docList[i], filename: docList[i])
            .then((value) {
          filePathNew.add(value);
        });
      }
    }

    var data = loginResponseModel?.detail?.files
        ?.where((element) => element.uploadedDoc != null)
        .toList()
        .map((e) => e.id)
        .join(",");

    var dataList = loginResponseModel?.detail?.files
        ?.where((element) => element.uploadedDoc != null)
        .toList()
        .map((e) => e.uploadedDoc.path)
        .join(",");
    List<String>? endUploadDataList = dataList?.split(',');
    filePath = [];
    if (dataList?.length != 0) {
      for (int i = 0; i < endUploadDataList!.length; i++) {
        await Dio.MultipartFile.fromFile(endUploadDataList[i],
                filename: endUploadDataList[i])
            .then((value) {
          filePath.add(value);
        });
      }
    }
    Dio.MultipartFile? file2;
    if (documentFile2 != null && documentFile2 != '') {
      file2 = await Dio.MultipartFile.fromFile(documentFile2 ?? "",
          filename: documentFile2!);
    }

    Map<String, dynamic> requestModel =
        AuthRequestModel.updateAccountRequestData(
            fullName: nameTextController?.text.trim(),
            identityNumber: identificationTextController?.text.trim(),
            gender: genderId ?? 0,
            workZone: commaSepratedLocationId.length == 0
                ? loginResponseModel?.detail?.workZone.toString()
                : commaSepratedLocationId.join(','),
            qualification: categoryList
                ?.where((element) => element.isSelected == true)
                .toList()
                .map((e) => e.id)
                .join(","),
            skill: selectedSubCategoryId?.join(","),
            experience: workExperienceController?.text.trim(),
            serviceLang: languageList
                ?.where((element) => element.isSelected == true)
                .toList()
                .map((e) => e.id)
                .join(","),
            email: emailTextController?.text.trim(),
            deviceName: _repository.deviceName ?? "",
            deviceType: _repository.deviceType,
            oldPassword: oldPasswordTextController?.text.trim(),
            newPassword: passwordTextController?.text.trim(),
            deviceToken: _repository.deviceID,
            password: passwordTextController?.text.trim(),
            address: addressTextController?.text.trim(),
            dob: formatted,
            certificateImage: filePath,
            profileImage: file2,
            fileNewUpload: filePathNew,
            fileId: data);
    _repository
        .updateProfileApiCall(dataBody: requestModel, contactNo: contactNo)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        hitprofileDetailApi(isUpdate: true);
        saveDataToLocalStorage(loginResponseModel);
        formGlobalKey.currentState?.reset();
        docList = [];
        flashBar(message: loginResponseModel?.message.toString() ?? "");
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      documentFile2 = file.path;
      update();
    }
  }

  /* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }
}
