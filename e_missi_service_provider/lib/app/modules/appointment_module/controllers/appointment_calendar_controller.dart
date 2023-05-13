/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AppointmentCalendarController extends GetxController {
  DateTime? startDate;
  DateTime? lastDate;
  List selectedDays = [];
  List selectedDays1 = [];
  List<DateTime> blackOutDays = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];
  List gridItems = [
    "09:00 am",
    "10:00 am",
    "12:00 am",
    "08:00 am",
    "07:00 am",
    "06:00 am",
    "05:00 am",
    "04:00 am",
    "09:00 am",
    "10:00 am",
    "12:00 am",
    "08:00 am",
  ];
  var selectedIndex;

  @override
  void onInit() {
    startDate = DateTime.now();

    super.onInit();
  }
}


