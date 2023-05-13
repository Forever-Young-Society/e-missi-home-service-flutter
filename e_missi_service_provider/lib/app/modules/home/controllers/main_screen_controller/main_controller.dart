/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MainController extends GetxController {
  GlobalKey<ScaffoldState> globalKeys = GlobalKey<ScaffoldState>();
  int selectedIndex = 0;
  List appBarTitle = [];
  var screens;
  int backPressCounter = 0;

  @override
  void onInit() {
    if(Get.arguments!=null){
      selectedIndex=Get.arguments['selectedIndex'];
    }

    super.onInit();
    appBarTitle = [
      '',
      strNotification,
      strPayout,
      strMyAppointment,
      strMyBookingAppointment
    ];
    screens = [
      HomeScreen(),
      NotificationScreen(),
      ProfileScreen(),
      MyAppointmentsScreen(),
      AppointmentScreen()
    ];
  }

  /*==============================================updateSelectedIndex=====================================*/

  updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  /*===================================================- On device back press======================================================*/

  Future<bool> onWillPop() {
    debugPrint(backPressCounter.toString());
    if (backPressCounter < 1) {
      flashBar(message: strBackPressMessage);
      backPressCounter++;
      Future.delayed(Duration(milliseconds: 1500), () {
        backPressCounter--;
      });
      return Future.value(false);
    } else {
      if (GetPlatform.isAndroid) {
        SystemNavigator.pop();
      }
      return Future.value(true);
    }
  }
}
