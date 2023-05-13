/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MyBusinessCalendarController extends GetxController {
  int isActive = 0;
  RxBool notifyOn = false.obs;
  final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();
  final Repository _repository = Get.find<Repository>();
  LoginResponseModel? _loginResponseModel;
  Rx<LoginDataModel>? loginModel = LoginDataModel().obs;
  CategoryListResponse? categoryListResponse;
  MySlotsResponseModel? mySlotsResponseModel;
  List<CategoryDataModel>? categoryList;
  List<MySlotsDataModel>? mySlotList;

  TextEditingController? serviceController;
  DateTime? startDate;
  DateTime? lastDate;
  var selectedDate;
  var selectedCategory;
  SuccessResponse? successResponse;

  @override
  void onInit() {
    startDate = DateTime.now();
    serviceController = TextEditingController();
    hitServiceCategoryAPI();
    super.onInit();
  }

  userLogoutApiCall() {
    _repository.logoutApiCall().then((value) async {
      if (value != null) {
        _loginResponseModel = value;
        flashBar(message: _loginResponseModel?.message.toString() ?? "");
        _preferenceManger.clearLoginData();
        Get.offAllNamed(AppRoutes.logIn);
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitServiceCategoryAPI() {
    _repository.myCategoryApiCall(isLoading: false).then((value) async {
      if (value != null) {
        categoryListResponse = value;
        categoryList = categoryListResponse!.list;

        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  slotsListAPI() {
    _repository
        .slotListApiCall(
            categoryId: selectedCategory,
            startTim: selectedDate.toString().replaceAll(".000", ""),
            endTim:
                selectedDate.toString().replaceAll("00:00:00.000", "23:59:59"))
        .then((value) async {
      if (value != null) {
        mySlotsResponseModel = value;
        mySlotList = mySlotsResponseModel?.list ?? [];

        bottomSheet(
            widget: SelectSlotScreen(),
            textLabel: convertDateToNormalDate(dateString: selectedDate));
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitAddSlotApi() {
    List<MySlotsDataModel>? postData =
        mySlotList?.where((e) => e.isSelected == true).map((e) => e).toList();
    postData?.forEach((element) {
      element.startTime =
          "${convertDateToSendDate(dateString: selectedDate)} ${element.startTime}";
      element.endTime =
          "${convertDateToSendDate(dateString: selectedDate)} ${element.endTime}";
    });
  if(postData==null|| postData.length==0)
    {
      flashBar(message: "Please select slot");
    }
  else{
    Map<String, dynamic> requestModel = AuthRequestModel.addSlotRequestModel(
        categoryId: selectedCategory, slotData: postData);
    _repository
        .addSlotsApiCall(dataBody: requestModel,
        startTim: selectedDate.toString().replaceAll(".000", ""),
        endTim:
        selectedDate.toString().replaceAll("00:00:00.000", "23:59:59")


    ).then((value) async {
      if (value != null) {
        successResponse = value;
        Get.back();
        flashBar(message: successResponse?.message ?? "");

      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
  }
}
