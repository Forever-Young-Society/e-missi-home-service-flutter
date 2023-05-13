/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';


class HomeServicesTermsScreen extends GetView<HomeServiceTermsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeServiceTermsController>(
      init: HomeServiceTermsController(),
      builder: (controller) {
        return Scaffold(
            body: Container(
          width: Get.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ic_background_image), fit: BoxFit.cover)),
          child: _bodyWidget(),
        ));
      },
    );
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(
              onTap: () {
                Get.back(result: true);
              },
              title:strTermsAndCondition),
          data(),
          rowCheckTerms(),
          acceptButton(),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);

  data() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HtmlWidget(
                controller.homeServicesTermsResponseModel.detail?.description ??
                    '')
          ],
        ),
      ).paddingOnly(top: margin_50),
    );
  }

  rowCheckTerms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            controller.check = !controller.check;
            controller.update();
          },
          child: AssetImageWidget(
            imageUrl: controller.check ? ic_checkk : ic_unchekc,
            imageHeight: height_20,
          ).paddingOnly(right: margin_10),
        ),
        TextView(
            text: strIAgreeToAll,
            textStyle: textStyleBody2()
                .copyWith(color: Colors.black, fontSize: font_15))
      ],
    ).paddingOnly(bottom: margin_10, top: margin_20);
  }

  acceptButton() {
    return MaterialButtonWidget(
      onPressed: () {
        if (controller.check == false) {
          flashBar(message: strPleaseAccepttermsAndConditions);
        } else {
          controller.serviceAcceptTermTermsApiCall(
              controller.homeServicesTermsResponseModel.detail?.id,
              controller.title);
        }
      },
      buttonText: strContinue.toUpperCase(),
    ).paddingOnly(top: margin_10);
  }
}
