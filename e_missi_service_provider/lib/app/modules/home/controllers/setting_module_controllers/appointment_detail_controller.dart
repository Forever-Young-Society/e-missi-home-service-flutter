/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AppointmentDetailController extends GetxController {
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
  @override
  void onInit() {

    super.onInit();
  }
  @override
  void onReady() {
    if (Get.arguments != null) {
      bookingID = Get.arguments['bookingId'];
      future = appointmentDetailApiCall(bookingID);
    }

    super.onReady();
  }
}
