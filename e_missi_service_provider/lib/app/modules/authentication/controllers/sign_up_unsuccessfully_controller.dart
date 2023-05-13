/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';

class SignUpUnSuccessFullyController extends GetxController {
  var resend = true;
  var contactNo;

  LoginResponseModel loginResponseModel = LoginResponseModel();
  final Repository _repository = Get.find<Repository>();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();

  @override
  void onInit() {
    if (Get.arguments != null) {
      contactNo = Get.arguments[contactIdKey];
    }
    super.onInit();
  }

  hitresendOtpApi() {
    Map<String, dynamic> requestModel = AuthRequestModel.resendOtpRequestModel(
      contactNo: contactNo,
    );
    _repository.resendApiCall(dataBody: requestModel).then((value) async {
      if (value != null) {
        loginResponseModel = value;
        saveDataToLocalStorage(loginResponseModel);
        Get.back(result: true);
        flashBar(message: '$strEmailOTP ${loginResponseModel.detail?.otp}');
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  /* ======================================================saveDataToLocalStorage=========================================*/

  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }
}
