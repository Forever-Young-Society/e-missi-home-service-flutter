/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController(), fenix: true);
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(),
    );

    Get.lazyPut<RatingController>(
      () => RatingController(),
    );

    Get.lazyPut<AppointmentDetailController>(
      () => AppointmentDetailController(),
    );

    Get.lazyPut<EditDependentController>(
      () => EditDependentController(),
    );

    Get.lazyPut<AppointmentController>(
      () => AppointmentController(),
    );

    Get.lazyPut<ServiceAddController>(
      () => ServiceAddController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<OrderServicesController>(
      () => OrderServicesController(),
    );

    Get.lazyPut<CardWebViewController>(
      () => CardWebViewController(),
    );
  }
}
