/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:carousel_slider/carousel_controller.dart';
import 'package:dio/dio.dart';
import 'package:e_missi_home_service/export.dart';

class HomeController extends GetxController {
  late Dio dio;

  int selectedIndex = 0;
  List myBookModelList = [];
  CarouselController carouselController = CarouselController();
  List imgList = [
    ICON_fys,
    ICON_medicalBook,
  ];

  List imgList1 = [
    ICON_shelter,
    ICON_stethoscope,
    ICON_trolley2,
  ];
  final Repository _repository = Get.find<Repository>();

  LoginResponseModel? loginResponseModel = LoginResponseModel();
  var stringList = [
    'Home Services',
    'Doctor Online',
    'Forever Young Health Store'
  ];
  var stringList1 = [
    'Health\nMonitoring',
    'My Health\nRecord',
  ];
  List<Color> colors1 = [lightBlue, lightGreen];
  List<Color> colors = [lightPink, blue, lightgreen];
  List<Color> comingSoonColors = [Colors.transparent, darkPurple, darkGreen];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    hitprofileDetailApi();
    super.onReady();
  }

  hitprofileDetailApi() {
    _repository.detailProfileApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  logoutApiCall() {
    _repository.logoutApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        Get.offAllNamed(AppRoutes.logoutRoute);
        flashBar(message: '${loginResponseModel?.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  deleteAccountApiCall() {
    _repository.deleteAccountApiCall().then((value) async {
      if (value != null) {
        loginResponseModel = value;
        Get.offAllNamed(AppRoutes.logoutRoute,
            arguments: {"isAccountDeleted": true});
        flashBar(message: '${loginResponseModel?.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  onPageChange({required int postion}) {
    selectedIndex = postion;
    update();
  }
}
