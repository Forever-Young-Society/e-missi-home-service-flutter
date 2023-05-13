/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:upgrader/upgrader.dart';

class MainBottomScreen extends StatelessWidget {
  var controller = Get.put<MainController>(MainController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      child: GetBuilder<MainController>(
          init: MainController(),
          builder: (controller) {
            return WillPopScope(
              onWillPop: () {
                controller.onWillPop();
                return Future.value();
              },
              child: UpgradeAlert(
                child: Scaffold(
                  bottomNavigationBar: NavigationBarTheme(
                    data: _navigationTheme(),
                    child: _navigationBar(),
                  ),
                  appBar: appBarFunctions(),
                  body: controller.screens[controller.selectedIndex],
                ),
              ),
            );
          }),
    );
  }

/*=======================================================appBarFunctions============================================*/

  appBarFunctions() {
    return controller.selectedIndex == 0 || controller.selectedIndex == 1
        ? PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(),
          )
        : CustomAppBar(
            appBarTitleText: controller.appBarTitle[controller.selectedIndex],
            leadingWidget: Container());
  }

/*==========================================================navigation bar==============================================*/

  _navigationBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
        ],
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: controller.selectedIndex,
        onDestinationSelected: (index) {
          controller.updateSelectedIndex(index);
          if (index == 3) {
            var controllers = Get.put(AppointmentController());
            controllers.onReady();
            controllers.isActive = 0;
            controllers.update();
          }
        },
        destinations: [
          NavigationDestination(
            icon: icons(image: ic_mediclegry),
            label: strHome,
            selectedIcon: icons(image: ic_mediclegry, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_profilegry),
            label: strProfile,
            selectedIcon: icons(image: ic_profilegry, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_notification),
            label: strNotification,
            selectedIcon: icons(image: ic_notification, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_caldrgry),
            label: strAppointment,
            selectedIcon: icons(image: ic_caldrgry, color: appColor),
          ),
        ],
      ),
    );
  }

/*==================================================for bottom navigation icon============================================*/

  icons({image, color}) {
    return Image.asset(
      image,
      scale: 3.5,
      color: color,
    );
  }

/*===========================================================theme of navigation bar==============================================*/

  _navigationTheme() {
    return NavigationBarThemeData(
      backgroundColor: whiteColor,
      labelTextStyle: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return textStyleHeading2().copyWith(
            color: appColor,
            fontSize: font_13,
          );
        }
        return textStyleHeading2().copyWith(
          color: Colors.grey.shade500,
          fontSize: font_13,
        );
      }),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
