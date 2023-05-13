/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:permission_handler/permission_handler.dart';

flashBar({required String message}) {
  Get.closeAllSnackbars();
  Get.snackbar(strApplicationName, message,
      barBlur: radius_50,
      backgroundColor: appColor,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
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

Future<void> requestPermissions(
    List<Permission> permissionType, Function(bool data) onTap) async {
  Map<Permission, PermissionStatus> statuses = await permissionType.request();

  if (statuses[Permission.camera] == PermissionStatus.granted &&
      statuses[Permission.storage] == PermissionStatus.granted) {
    onTap(true);
  } else if (statuses[Permission.camera] ==
          PermissionStatus.permanentlyDenied ||
      statuses[Permission.storage] == PermissionStatus.permanentlyDenied) {
    Get.defaultDialog(
        title: 'Permission Required!',
        content: Column(
          children: [
            TextView(
                text: 'Please enable required permission !',
                maxLine: 3,
                textStyle: textStyleHeading2().copyWith(fontSize: font_14)),
            SizedBox(
              height: height_20,
            ),
            Row(
              children: [
                Expanded(
                    child: MaterialButtonWidget(
                  buttonText: strNo,
                  onPressed: () {
                    Get.back();
                  },
                  textColor: Colors.white,
                ).paddingSymmetric(horizontal: margin_20)),
                Expanded(
                    child: MaterialButtonWidget(
                  buttonText: 'Allow',
                  textColor: Colors.white,
                  onPressed: () {
                    Get.back();
                    openAppSettings();
                  },
                ).paddingSymmetric(horizontal: margin_20)),
              ],
            )
          ],
        ));
  } else {
    await Permission.camera.request();
    await Permission.storage.request();
  }
}
