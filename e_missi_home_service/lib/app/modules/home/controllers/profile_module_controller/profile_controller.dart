/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:e_missi_home_service/export.dart';


class ProfileController extends BaseController {
  final Repository _repository = Get.find<Repository>();

  LoginResponseModel loginResponseModel = LoginResponseModel();
  DependentListResponseModel dependentListResponseModel =
      DependentListResponseModel();

  List<DependentListDataModel> dependentList = [];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    hitprofileDetailApi();
    hitdepedentListApi();
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

  hitdepedentListApi() {
    _repository.dependentListApiCall(isLoading: false).then((value) async {
      if (value != null) {
        dependentListResponseModel = value;
        dependentList = dependentListResponseModel.list!;
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}
