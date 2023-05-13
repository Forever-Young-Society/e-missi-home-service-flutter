/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:e_missi_home_service/export.dart';


class HomeServiceController extends GetxController {
  CategoryListResponse? categoryListResponse;

  List<CategoryDataModel>? categoryList = [];

  var selectedIndex;
  final Repository _repository = Get.find<Repository>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    categoryListResponse = CategoryListResponse();
    hitServiceCategoryAPI();
    super.onReady();
  }

  hitServiceCategoryAPI() {
    _repository.serviceCategoryApiCall().then((value) async {
      if (value != null) {
        categoryListResponse = value;
        categoryList = categoryListResponse!.list;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}

class HomeIconText {
  String? icon;
  String? title;

  HomeIconText({this.icon, this.title});
}
