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

class StaticPageScreen extends GetView<StaticPageController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaticPageController>(
      init: StaticPageController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Scaffold(
              body: Container(
            width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ic_background_image), fit: BoxFit.cover)),
            child: _bodyWidget(),
          )),
        );
      },
    );
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBarView(
              title: controller.staticPagesResponseModel.detail?.title ?? ''),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HtmlWidget(
                      controller.staticPagesResponseModel.detail?.description ??
                          '')
                ],
              ),
            ).paddingOnly(top: margin_50),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);
}
