/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:intl/intl.dart';

class AppointmentDetailConfirmationController extends GetxController {
  BookingDetailResponseModel? bookingDetailResponseModel;
  final Repository _repository = Get.find<Repository>();
  var bookingID, orderId;
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
  void onReady() {
    debugPrint("${Get.arguments}===");
    if (Get.arguments != null) {
      bookingID = Get.arguments['bookingId'];
      orderId = Get.arguments['orderId'];
      future = appointmentDetailApiCall(bookingID);
    }

    super.onReady();
  }

  getDate(String startime, String endtime) {
    if (startime != null &&
        startime.isNotEmpty &&
        endtime != null &&
        endtime.isNotEmpty) {
      String date = DateFormat("dd MMM yyyy").format(DateTime.parse(startime));
      String startTime = DateFormat("hh:mm a").format(DateTime.parse(startime));
      String endTime = DateFormat("hh:mm a").format(DateTime.parse(endtime));
      return date + " - " + startTime + " - " + endTime;
    } else {
      return "";
    }
  }
}
