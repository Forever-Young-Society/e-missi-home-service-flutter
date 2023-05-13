/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import '../../../../export.dart';

class SignUpUnSuccessfullyScreen
    extends GetView<SignUpUnSuccessFullyController> {
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
            imageHeight: height_80,
          ).paddingOnly(top: margin_10),
          AssetImageWidget(
            imageUrl: ic_cross,
            imageFitType: BoxFit.cover,
            imageHeight: height_120,
          ).paddingOnly(top: height_150),
          Text(
            strSignUpUnsuccessfully,
            style: TextStyle(fontSize: font_24),
          ).paddingOnly(top: margin_50),
          MaterialButtonWidget(
            onPressed: () {
              controller.hitresendOtpApi();
            },
            buttonText: strRetry.toUpperCase(),
          ).paddingOnly(top: margin_30),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);
}
