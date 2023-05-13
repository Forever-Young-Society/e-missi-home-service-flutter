/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

alertDialogWidget({
  final String? title,
  final String? description,
  final Widget? contentWidget,
  final Function? onTab,
}) {
  return Get.defaultDialog(
      titlePadding: EdgeInsets.only(top: margin_15),
      contentPadding: EdgeInsets.only(
          bottom: margin_20, top: margin_10, left: margin_10, right: margin_10),
      title: title ?? "",
      titleStyle: textStyleHeading().copyWith(fontWeight: FontWeight.w600),
      barrierDismissible: false,
      content: contentWidget ??
          Text(
            description!,
            textAlign: TextAlign.center,
            style: textStyleBody1(),
          ),
      confirm: MaterialButtonWidget(
        minWidth: Get.width / 4,
        elevation: elvation_0,
        padding: height_12,
        fontsize: font_12,
        buttonText: strNo,
        textColor: Colors.white,
        onPressed: () {
          Get.back();
        },
      ).paddingOnly(top: margin_10),
      cancel: MaterialButtonWidget(
        minWidth: Get.width / 4,
        elevation: elvation_0,
        padding: height_12,
        fontsize: font_12,
        onPressed: onTab!,
        textColor: Colors.white,
        buttonText: strYes,
      ).paddingOnly(top: margin_10));
}

logoutDialog({
  text,
  confirmText,
  onTap,
  bool textfeild = false,
}) {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin_30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(margin_10)),
              child: Column(
                children: [
                  SizedBox(height: height_30),
                  TextView(
                    text: text,
                    maxLine: 5,
                    textStyle: textStyleBody2().copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: font_18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  textfeild == true ? SizedBox(height: height_10) : Container(),
                  textfeild == true
                      ? Container(
                          width: Get.width,
                          padding: EdgeInsets.all(margin_10),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(radius_8)),
                          child: TextField(
                            maxLines: 8,
                            minLines: 8,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Please write here...',
                                hintStyle: textStyleBody2()
                                    .copyWith(color: Colors.black38)),
                          ),
                        ).paddingSymmetric(horizontal: margin_15)
                      : Container(),
                  SizedBox(height: height_30),
                  Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: TextView(
                            text: strCancel,
                            textStyle: textStyleBody2().copyWith(
                                color: Colors.black,
                                fontSize: font_18,
                                fontWeight: FontWeight.w500),
                          )),
                      Container(
                        width: 1,
                        height: height_45,
                        color: Colors.grey,
                      ),
                      InkWell(
                        onTap: () {
                          onTap();
                        },
                        child: TextView(
                          text: confirmText,
                          textStyle: textStyleBody2().copyWith(
                              color: purple,
                              fontSize: font_18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}

alertDialog({onTap, text, bool alert = false, icon}) {
  return Get.dialog(
    Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin_30),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(margin_10)),
              child: Column(
                children: [
                  alert == true
                      ? AssetImageWidget(
                              imageUrl: icon ?? alert_gif,
                              imageFitType: BoxFit.fill,
                              imageHeight: height_50)
                          .paddingOnly(top: margin_10)
                      : SizedBox(
                          height: height_30,
                        ),
                  TextView(
                    maxLine: 5,
                    text: text,
                    textStyle: textStyleBody2().copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: font_17,
                    ),
                    textAlign: TextAlign.center,
                  ).paddingOnly(
                      bottom: margin_20, left: margin_20, right: margin_20),
                  InkWell(
                    onTap: () {
                      onTap();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: margin_10),
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(radius_10),
                              bottomLeft: Radius.circular(radius_10))),
                      width: Get.width,
                      child: TextView(
                        text: strOk,
                        textStyle: textStyleBody2()
                            .copyWith(color: Colors.white, fontSize: font_18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
