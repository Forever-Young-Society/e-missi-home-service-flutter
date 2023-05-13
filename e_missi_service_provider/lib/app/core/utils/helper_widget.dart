/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

flashBar({required String message}) {
  Get.closeAllSnackbars();
  Get.snackbar(strApplicationName, message,
      barBlur: radius_50,
      backgroundColor: darkPurple,
      snackPosition: SnackPosition.BOTTOM,
      colorText: lightPink,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(horizontal: margin_10, vertical: margin_20));
}
/*==========================================sizeBox=========================================*/

sizeBox({height, width}) => SizedBox(
      height: height,
      width: width,
    );
/*==================================================cardTextView==========================================*/

Widget cardTextView(
    {title,
    subTitle,
    Color? titleColor,
    Color? subTitleColor,
    maxLine,
    colon,
    subtilteWeight}) {
  return Row(
    children: [
      Expanded(
          child: TextView(
        text: title,
        textStyle: textStyleBody1().copyWith(
            color: titleColor ?? Colors.black, fontWeight: FontWeight.w600),
        textAlign: TextAlign.start,
      )),
      TextView(text: ":\t\t\t", textStyle: textStyleHeading2()),
      Expanded(
          child: TextView(
              text: subTitle,
              textStyle: textStyleBody1().copyWith(
                  color: subTitleColor ?? Colors.grey.shade500,
                  fontWeight: subtilteWeight ?? FontWeight.w600),
              maxLine: maxLine ?? 1,
              textAlign: TextAlign.start))
    ],
  );
}
