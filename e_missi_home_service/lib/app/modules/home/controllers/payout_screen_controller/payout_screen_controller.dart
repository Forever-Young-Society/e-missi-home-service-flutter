/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class PayOutControllerController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List weekList = [];
  RxInt selectedIndex = 0.obs;
  RxInt selectedTransaction = 0.obs;
  TabController? tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    weekList = [strToday, strWeekly, strMonthly, strYearly];
  }

  updateTransactionValue(index) {
    selectedTransaction.value = index;
  }
}
