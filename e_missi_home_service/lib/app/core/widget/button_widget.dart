/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? padding;
  final onPressed;
  final decoration;
  final elevation;
  final bool? isSocial;
  final double? fontsize;
  final Widget? iconWidget;

  const MaterialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonColor,
    this.borderColor,
    this.textColor,
    this.buttonRadius = defaultRaduis,
    this.decoration,
    this.isSocial = false,
    this.onPressed,
    this.elevation,
    this.iconWidget,
    this.fontsize,
    this.minWidth,
    this.minHeight,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: minHeight,
        splashColor: Colors.transparent,
        minWidth: minWidth ?? Get.width,
        color: buttonColor ?? appColor,
        elevation: elevation ?? radius_4,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor ?? appColor),
            borderRadius: BorderRadius.circular(buttonRadius!)),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: padding ?? margin_15),
        child: TextView(
            text: buttonText!,
            textStyle: textStyleButton().copyWith(
                color: textColor ?? Colors.white,
                fontSize: fontsize,
                fontWeight: FontWeight.w500)));
  }
}
