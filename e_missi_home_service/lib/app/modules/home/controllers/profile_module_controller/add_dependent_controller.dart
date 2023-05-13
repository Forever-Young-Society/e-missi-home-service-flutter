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
import '../../../../../export.dart';


class AddDependentController extends BaseController {
  TextEditingController? confirmTextController = TextEditingController();
  TextEditingController? nameTextController = TextEditingController();
  TextEditingController? ageTextController = TextEditingController();
  TextEditingController? identificationTextController = TextEditingController();
  TextEditingController? zipTextController = TextEditingController();
  TextEditingController? mobileTextController = TextEditingController();
  TextEditingController? addressTextController = TextEditingController();
  TextEditingController? medicalConditionTextController =
      TextEditingController();
  TextEditingController? dobTextController = TextEditingController();
  TextEditingController? passwordTextController = TextEditingController();
  TextEditingController? emailTextController = TextEditingController();
  FocusNode? confirmFocusNode = FocusNode();
  FocusNode? nameFocusNode = FocusNode();
  FocusNode? identificationFocusNode = FocusNode();
  FocusNode? mobileFocusNode = FocusNode();
  FocusNode? addressFocusNode = FocusNode();
  FocusNode? medicalConditionFocusNode = FocusNode();
  FocusNode? dobFocusNode = FocusNode();
  FocusNode? zipFocusNode = FocusNode();
  FocusNode? ageFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode? genderFocusNode;
  TextEditingController? genderTextController = TextEditingController();
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
  FocusNode? passwordFocusNode;
  String? formatted;
  var isEdit;
  var edit = false;
  var fileName, extension;
  File? documentFile;
  int? sizeInBytes;
  double? sizeInMb;
  String? profileImageFile;
  final Repository _repository = Get.find<Repository>();
  DependentDetailResponseModel dependentDetailResponseModel =
      DependentDetailResponseModel();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  LoginDataModel loginData = LoginDataModel();

  @override
  void onInit() {
    if (Get.arguments != null) {
      isEdit = Get.arguments[isEditKey];
      debugPrint(' isEdit  ${Get.arguments[isEditKey]}');
    }

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

  updateImageFile(Future<PickedFile?> imagePath) async {
    PickedFile? file = await imagePath;
    if (file != null) {
      profileImageFile = file.path;
      update();
    }
  }

  hitAddDependentAccountApi() async {
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

    Map<String, dynamic> requestModel =
        AuthRequestModel.addDependentAccountRequestModel(
      email: emailTextController?.text.trim(),
      files: files,
      zipCode: zipTextController?.text.trim(),
      IdentityNumber: identificationTextController?.text.trim(),
      mobile: mobileTextController?.text.trim(),
      profileFile: profilePicture,
      address: addressTextController?.text.trim(),
      aboutMe: medicalConditionTextController?.text.trim(),
      dob: formatted,
      gender: genderId,
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
    confirmTextController!.clear();
    ageTextController!.clear();
    nameTextController!.clear();
    zipTextController!.clear();
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
