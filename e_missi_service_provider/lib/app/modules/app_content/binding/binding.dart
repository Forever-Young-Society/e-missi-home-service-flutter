/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import '../../../../export.dart';

class AppContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppContentController>(
      () => AppContentController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
