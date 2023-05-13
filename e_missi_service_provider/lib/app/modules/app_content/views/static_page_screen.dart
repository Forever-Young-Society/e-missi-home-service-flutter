/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AppContentScreen extends BaseView<AppContentController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(
      appBarTitleText: controller.type,
    );
  }

  @override
  Color pageBackgroundColor() {
    return Colors.white;
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            color: Colors.white,
            child: TextView(
              text: strDummyText,
              maxLine: appConatct,
              textAlign: TextAlign.start,
              textStyle: textStyleBody1().copyWith(
                  fontWeight: FontWeight.w400, fontSize: font_13point5),
            )).paddingSymmetric(horizontal: margin_15, vertical: margin_10));
  }
}
