/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class StaticPageController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  StaticPagesResponseModel staticPagesResponseModel =
      StaticPagesResponseModel();
  var type;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getArguments();
    super.onReady();
  }

  getArguments() {
    if (Get.arguments != null) {
      if (Get.arguments[typeKey] != null) {
        type = Get.arguments[typeKey];
        getPagesApiCall(type);
      }
    }
  }

  getPagesApiCall(type) {
    _repository.getPagesApiCall(typdId: type,).then((value) async {
      if (value != null) {
        staticPagesResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}
