/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

int defaultItemCount = 10;

var log = Logger();
GetStorage storage = GetStorage();

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
    GlobalKey<ScaffoldMessengerState>();

void showInSnackBar({required String message}) {
  scaffoldMessengerState.currentState?.activate();

  scaffoldMessengerState.currentState?.showSnackBar(SnackBar(
    elevation: elvation_2,
    dismissDirection: DismissDirection.horizontal,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin_10))),
    backgroundColor: appColor,
    behavior: SnackBarBehavior.floating,
    content: TextView(
        textAlign: TextAlign.start,
        maxLine: 5,
        text: message,
        textStyle: textStyleBody2().copyWith(
            fontSize: font_12,
            color: Colors.white,
            fontWeight: FontWeight.w500)),
    duration: const Duration(seconds: 2),
  ));
}
