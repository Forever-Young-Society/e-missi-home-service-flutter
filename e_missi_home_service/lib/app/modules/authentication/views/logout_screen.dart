/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class LogoutScreen extends GetView<LogoutController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.offAllNamed(AppRoutes.logIn);
          return Future.value(true);
        },
        child: GetBuilder<LogoutController>(
          init: LogoutController(),
          builder: (controller) {
            return Scaffold(
                body: Container(
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(ic_background_image),
                      fit: BoxFit.cover)),
              child: _bodyWidget(),
            ));
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AssetImageWidget(
            imageUrl: ic_splash_logo_image,
            imageFitType: BoxFit.cover,
            imageHeight: height_70,
          ).paddingOnly(top: margin_10),
          AssetImageWidget(
            imageUrl: ic_success_image,
            imageFitType: BoxFit.cover,
            imageHeight: height_120,
          ).paddingOnly(top: height_130),
          Text(
            controller.isAccountDeleted == true
                ? strAccountDeletedSuccessful
                : strYouHaveLoggedOut,
            style: TextStyle(fontSize: font_24),
          ).paddingOnly(top: margin_70),
          MaterialButtonWidget(
            onPressed: () {
              Get.offAllNamed(AppRoutes.logIn);
            },
            buttonText: strSignIn.toUpperCase(),
          ).paddingOnly(top: margin_30),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);
}
