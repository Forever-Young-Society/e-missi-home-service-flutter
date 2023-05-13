/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class ResetPassController extends GetxController {
  TextEditingController? confirmTextController;
  FocusNode? confirmFocusNode;
  TextEditingController? passwordTextController;
  FocusNode? passwordFocusNode;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  var countryCode;
  bool isHide = true;
  bool isHide2 = true;
  var contactNo;

  @override
  void onInit() {
    if (Get.arguments != null) {
      contactNo = Get.arguments[contactIdKey];
      debugPrint('mobile number ${contactNo.toString()}');
    }

    initEditTextController();
    super.onInit();
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
    confirmFocusNode = FocusNode();
    passwordTextController = TextEditingController();
    passwordFocusNode = FocusNode();
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoOtpScreen() {
    Get.offNamed(AppRoutes.logIn);
    clearEditText();
  }

  /* ======================================================= clear Edit Text ===========================================*/

  clearEditText() {
    confirmTextController?.clear();
    passwordTextController?.clear();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitResetPasswordApi() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.changePasswordRequestModel(
      password: passwordTextController!.text.trim(),
    );
    _repository
        .changePasswordApiCall(dataBody: requestModel, contactNo: contactNo)
        .then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        flashBar(message: '${loginResponseModel?.message}');
        gotoOtpScreen();
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
