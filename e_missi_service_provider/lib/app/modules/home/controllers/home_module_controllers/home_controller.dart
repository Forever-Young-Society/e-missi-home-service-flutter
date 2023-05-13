/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class HomeController extends SuperController {
  RxBool isfaq = true.obs;
  RxBool isMyBook = true.obs;
  int backPressCounter = 0;
  int selectedIndex = 0;
  var downloadPercent = 0.0.obs;
  List myBookModelList = [];
  CarouselController carouselController = CarouselController();
  List myBookModelListCopy = [];
  RxString fullPath = ''.obs;
  RxBool homeLoader = false.obs;
  String? directoryPath;
  String? extension;
  String? fileName;
  bool loadingPath = false;
  List<PlatformFile>? paths;
  List imgList = [
    ICON_fys,
    ICON_medicalBook,
  ];

  List<HomeIconText> gridItems = [
    HomeIconText(icon: ic_calendar, title: strMyCalendar),
    HomeIconText(icon: ic_appointments, title: strMyBookingAppointments),
    HomeIconText(icon: ic_booking_history, title: strMyBookingHistory),
    HomeIconText(icon: ic_rating_reviews, title: strRatingReview),
  ];

  List imgList1 = [
    ICON_shelter,
    ICON_stethoscope,
    ICON_trolley2,
  ];

  var stringList = ['Home Services', 'Doctor Online', 'e-Pharmacy Store'];
  var stringList1 = [
    'Health\nMonitoring',
    'My Health\nRecord',
  ];
  List<Color> colors1 = [lightBlue, lightGreen];
  List<Color> colors = [lightPink, blue, lightgreen];
  List<Color> comingSoonColors = [Colors.transparent, darkPurple, darkGreen];
  final Repository _repository = Get.find<Repository>();
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();

  @override
  void onInit() {
    super.onInit();
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
        saveDataToLocalStorage(loginResponseModel);
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
        saveDataToLocalStorage(loginResponseModel);
        Get.offAllNamed(AppRoutes.logoutRoute,arguments: {
          "isAccountDeleted":true
        });
        flashBar(message: '${loginResponseModel?.message.toString()}');
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }


  saveDataToLocalStorage(LoginResponseModel? loginResponseModel) {
    _preferenceManger.saveAuthToken(loginResponseModel?.accessToken ?? "");
    _preferenceManger.saveRegisterData(loginResponseModel?.detail);
  }

  @override
  void onReady() {
    hitprofileDetailApi();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onDetached() {
    log.e("onDetached");
  }

  @override
  void onInactive() {
    log.e("onInactive");
  }

  @override
  void onPaused() {
    log.e("onPaused");
  }

  @override
  void onResumed() {
    log.e("onResumed");
  }

  onPageChange({required int postion}) {
    selectedIndex = postion;
    update();
  }
}
