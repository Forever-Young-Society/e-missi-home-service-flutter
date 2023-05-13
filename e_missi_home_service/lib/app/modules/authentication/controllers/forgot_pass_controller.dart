/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ForgotPassController extends GetxController {
  TextEditingController? contactEditTextController;
  FocusNode? mobileFocusNode;
  TextEditingController? passwordTextController;
  FocusNode? passwordFocusNode;
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  int backPressCounter = 0;
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  var countryCode;
  bool isHide = false;

  @override
  void onInit() {
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
    contactEditTextController = TextEditingController();
    mobileFocusNode = FocusNode();
    passwordTextController = TextEditingController();
    passwordFocusNode = FocusNode();
  }

  /* ========================================================gotoOtpScreen ============================================*/

  gotoOtpScreen() {
    Get.toNamed(AppRoutes.otpRoute, arguments: {
      'isReset': true,
      contactIdKey: loginResponseModel?.detail?.contactNo ?? "",
      otpAttemptIdKey: loginResponseModel?.detail?.otpAttempt ?? "",
      otpIdKey: loginResponseModel?.detail?.otp ?? "",
    });
    clearEditText();
  }

  /* =======================================================clearEditText===========================================*/

  clearEditText() {
    contactEditTextController?.clear();
    passwordTextController?.clear();
  }

  /* ====================================================== hitLoginApi =========================================*/

  hitforgotApiCall() {
    Map<String, dynamic> requestModel =
        AuthRequestModel.forgotPasswordRequestModel(
      email: '${contactEditTextController?.text.trim()}',
    );
    _repository.forgotApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        gotoOtpScreen();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ====================================================== saveDataToLocalStorage =========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  @override
  void dispose() {
    clearEditText();
    super.dispose();
  }
}
