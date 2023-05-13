/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? appBarTitleText;
  final Widget? leadingWidget;
  final Widget? actionWidget;
  final Widget? titleWidget;
  final Color? leadingColor;
  final Color? bgColor;
  final bool? titleInCentre;
  final Function? onTap;
  final double? leadingWidth;
  final bool? isLight;

  CustomAppBar({
    Key? key,
    this.appBarTitleText = "",
    this.leadingWidget,
    this.leadingColor,
    this.actionWidget,
    this.titleInCentre,
    this.onTap,
    this.titleWidget,
    this.bgColor,
    this.leadingWidth,
    this.isLight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Padding(
        padding: EdgeInsets.only(top: margin_10, left: margin_8),
        child: AppBar(
          leadingWidth: leadingWidth,
          backgroundColor: bgColor ?? Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  isLight == true ? Brightness.light : Brightness.dark,
              statusBarBrightness:
                  isLight == true ? Brightness.light : Brightness.dark),
          elevation: 0.0,
          title: titleWidget ??
              Text(appBarTitleText ?? "",
                  style: textStyleHeading()
                      .copyWith(fontWeight: FontWeight.w700, color: purple)),
          leading: leadingWidget ??
              InkWell(
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: height_12),
                      child: Image.asset(
                        ic_back,
                        color: leadingColor,
                      )),
                  onTap: () {
                    if (onTap == null) {
                      Get.back(result: true);
                    } else {
                      onTap!();
                    }
                  }),
          centerTitle: titleInCentre ?? true,
          actions: [actionWidget ?? Container()],
        ),
      ),
      preferredSize: Size.fromHeight(50.0),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
