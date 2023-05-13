/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<LoginController>(
      () => LoginController(),
    );

    Get.lazyPut<EditDependentController>(
      () => EditDependentController(),
    );

    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );

    Get.lazyPut<OTPController>(
      () => OTPController(),
    );

    Get.lazyPut<ForgotPassController>(
      () => ForgotPassController(),
    );
    Get.lazyPut<ResetPassController>(
      () => ResetPassController(),
    );
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(),
    );

    Get.lazyPut<StaticPageController>(
      () => StaticPageController(),
    );

    Get.lazyPut<LogoutController>(
      () => LogoutController(),
    );

    Get.lazyPut<RegistrationController>(
      () => RegistrationController(),
    );

    Get.lazyPut<OTPController>(
      () => OTPController(),
    );

    Get.lazyPut<ForgotPassController>(
      () => ForgotPassController(),
    );
    Get.lazyPut<ResetPassController>(
      () => ResetPassController(),
    );
    Get.lazyPut<CreateAccountController>(
      () => CreateAccountController(),
    );

    Get.lazyPut<StaticPageController>(
      () => StaticPageController(),
    );

    Get.lazyPut<LogoutController>(
      () => LogoutController(),
    );

    Get.lazyPut<SubMissionController>(
      () => SubMissionController(),
    );

    Get.lazyPut<ApprovalController>(
      () => ApprovalController(),
    );

    Get.lazyPut<SignUpUnSuccessFullyController>(
      () => SignUpUnSuccessFullyController(),
    );

    Get.lazyPut<FAQController>(
          () => FAQController(),
    );

  }
}
