/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginController extends GetxController {
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
      Get.snackbar(
        strMissiHoemService,
        strPressAgainback,
        borderRadius: 6.0,
        backgroundColor: darkPurple,
        margin: EdgeInsets.all(margin_10),
        colorText: lightPink,
      );
      backPressCounter++;
      Future.delayed(Duration(milliseconds: 2500), () {
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

  /* ======================================================== go to Otp Screen ============================================*/

  gotoMainScreen() {
    Get.toNamed(AppRoutes.mainScreen);
    clearEditText();
  }

  /* =======================================================clearEditText===========================================*/

  clearEditText() {
    contactEditTextController?.clear();
    passwordTextController?.clear();
  }

  /* ======================================================hitLoginApi=========================================*/

  hitLoginApi() async {
    if (!Get.isRegistered<LoginController>()) {
      Get.lazyPut<LoginController>(
        () => LoginController(),
      );
    }
    Map<String, dynamic> requestModel = AuthRequestModel.loginRequestModel(
        password: passwordTextController?.text.trim(),
        contact: '${contactEditTextController?.text.trim().toString()}',
        deviceName: _repository.deviceName ?? "",
        deviceType: _repository.deviceType,
        deviceToken: await FirebaseMessaging.instance.getToken(),
        roleId: ROLE_USER);
    _repository.loginApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        flashBar(message: '${loginResponseModel?.message.toString()}');
        gotoMainScreen();
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
