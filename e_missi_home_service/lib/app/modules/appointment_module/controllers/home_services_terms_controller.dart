/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class HomeServiceTermsController extends GetxController {
  var check = false;
  final Repository _repository = Get.find<Repository>();
  HomeServicesTermsResponseModel homeServicesTermsResponseModel =
      HomeServicesTermsResponseModel();
  var type;
  var title;

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
      if (Get.arguments[catKey] != null) {
        type = Get.arguments[catKey];
        title = Get.arguments[serviceTitle];
        getHomeServicesTermsApiCall(type);
      }
    }
  }

  getHomeServicesTermsApiCall(type) {
    _repository.getHomeServicesTermsApiCall(catId: type).then((value) async {
      if (value != null) {
        homeServicesTermsResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  serviceAcceptTermTermsApiCall(type,title) {
    _repository.serviceAcceptTermTermsApiCall(termId: type).then((value) async {
      if (value != null) {
        homeServicesTermsResponseModel = value;
        Get.toNamed(AppRoutes.nursingService, arguments: {
          catKey: type,
          serviceTitle:title,
        });
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}
