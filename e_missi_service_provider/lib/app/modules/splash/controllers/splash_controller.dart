/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class SplashController extends GetxController {
  var timer;

  final Repository _repository = Get.find<Repository>();
  LoginResponseModel? loginResponseModel = LoginResponseModel();

  @override
  void onInit() {
    getNotification();
    _navigateToNextScreen();
    super.onInit();
  }

  getNotification() async {
    await PushNotificationsManager().init();
  }

  /*============================================navigation to next screen==========================================*/

  _navigateToNextScreen() =>
      timer = Timer(const Duration(milliseconds: 3500), () async {
        navigate();
      });

  navigate() {
    bool? isFirstLaunched =
        Get.find<PreferenceManger>().getStatusFirstLaunch() ?? false;
    if (isFirstLaunched == false) {
      Get.offAllNamed(AppRoutes.onBoarding);
    } else {
      if (isRedirectSplash == false) {
        hitCheckAPI();
      }
    }
  }

  /*================================================================ check api ===============================================*/

  hitCheckAPI() {
    _repository.checkApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        if (loginResponseModel!.detail!.step.toString() ==
            stepThree.toString()) {
          Get.offAllNamed(AppRoutes.mainScreen);
        } else if (loginResponseModel!.detail!.step.toString() ==
            stepTwo.toString()) {
          Get.toNamed(AppRoutes.createAccountRoute);
        }
        update();
      }
    }).onError((error, stackTrace) {
      Get.offNamed(AppRoutes.logIn);
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
