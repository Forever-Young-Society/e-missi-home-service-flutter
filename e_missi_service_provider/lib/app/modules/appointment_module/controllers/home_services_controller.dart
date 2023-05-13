/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class HomeServiceController extends GetxController {
  DateTime? startDate;
  DateTime? lastDate;
  List selectedDays = [];
  List selectedDays1 = [];
  List<DateTime> blackOutDays = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 2)),
    DateTime.now().add(Duration(days: 4))
  ];
  List<HomeIconText> gridItems = [
    HomeIconText(icon: ic_nurse_image, title: strNursingService),
    HomeIconText(icon: ic_careGiver_image, title: strCaregiver),
    HomeIconText(icon: ic_physiioc_image, title: strPhysiotherapy),
    HomeIconText(icon: ic_accup_image, title: strAcupuncture),
  ];
  var selectedIndex;

  @override
  void onInit() {
    startDate = DateTime.now();

    super.onInit();
  }
}

class HomeIconText {
  String? icon;
  String? title;

  HomeIconText({this.icon, this.title});
}
