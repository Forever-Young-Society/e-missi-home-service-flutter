/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';
import 'package:upgrader/upgrader.dart';

class MainBottomScreen extends GetView<MainController> {
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

/*======================================================= appBarFunctions ============================================*/

  appBarFunctions() {
    return controller.selectedIndex == 0 || controller.selectedIndex == 2
        ? PreferredSize(
            preferredSize: Size.fromHeight(0.0),
            child: Container(),
          )
        : PreferredSize(
            preferredSize: Size.fromHeight(height_100),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.appBarTitle[controller.selectedIndex] ?? "",
                    style: TextStyle(color: appColor, fontSize: font_20)),
              ],
            ).paddingOnly(top: margin_40),
          );
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
        onDestinationSelected: (index) =>
            {controller.updateSelectedIndex(index)},
        destinations: [
          NavigationDestination(
            icon: icons(image: ic_home_cion),
            label: strHome,
            selectedIcon: icons(image: ic_home_cion, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_notification),
            label: strNotification,
            selectedIcon: icons(image: ic_notification, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_profilegry),
            label: strProfile,
            selectedIcon: icons(image: ic_profilegry, color: appColor),
          ),
          NavigationDestination(
            icon: icons(image: ic_duty_icon),
            label: strDutyStart,
            selectedIcon: icons(image: ic_duty_icon, color: appColor),
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
            fontSize: font_10point,
          );
        }
        return textStyleHeading2().copyWith(
          color: Colors.grey.shade500,
          fontSize: font_10point,
        );
      }),
      indicatorColor: Colors.transparent,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    );
  }
}
