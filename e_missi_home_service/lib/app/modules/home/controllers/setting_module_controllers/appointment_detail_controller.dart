/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class AppointmentDetailController extends GetxController {
  int isActive = 0;
  var button;
  TextEditingController reasonController = new TextEditingController();
  BookingDetailResponseModel? bookingDetailResponseModel;
  final Repository _repository = Get.find<Repository>();
  var bookingID;
  Future? future;

  appointmentDetailApiCall(bookingID) async {
    await _repository.bookingDetailApiCall(bookingID).then((value) async {
      bookingDetailResponseModel = value;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  cancelAppointmentApiCall() async {
    if (reasonController.text.trim() == null ||
        reasonController.text.trim().isEmpty) {
      flashBar(message: strPleaseAddReason);
    } else {
      var data = AuthRequestModel.cancelBookingRequestModel(
          reason: reasonController.text.toString().trim());
      await _repository
          .cancelBookingApiCall(data, bookingDetailResponseModel?.detail?.id)
          .then((value) async {
        bookingDetailResponseModel = value;
        Get.back();
        alertDialog(
            text: strYourAppointmentCancelllation,
            onTap: () {
              Get.back(result: 1);
              Get.back(result: 1);
            });
        update();
      }).onError((error, stackTrace) {
        flashBar(message: error.toString());
      });
    }
  }

  bool isNotified = false;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments != null) {
      bookingID = Get.arguments['bookingId'];
      button = Get.arguments['rate'];
      isNotified = Get.arguments['isNotified'];
      future = appointmentDetailApiCall(bookingID);
    }

    super.onReady();
  }
}
