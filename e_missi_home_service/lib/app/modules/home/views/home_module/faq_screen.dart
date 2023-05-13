/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/app/core/utils/animation_expand_widget.dart';
import 'package:e_missi_home_service/export.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class FAQScreen extends GetView<FAQController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FAQController>(
      init: FAQController(),
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
          appBarView(title: strFaqHelp),
          Expanded(
            child: _listView(),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_20, vertical: margin_25);

  _listView() {
    return controller.faqList?.length == 0 || controller.faqList?.length == null
        ? Center(
            child: Text(strNoDataFound),
          )
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.faqList?.length ?? 0,
            itemBuilder: (context, index) {
              var item = controller.faqList?[index];
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      item!.isSelected = !item.isSelected;
                      controller.update();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item?.question ?? "",
                          style: textStyleBody2().copyWith(
                              color: color_black_grey, fontSize: font_18),
                        ),
                        RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0)
                                .animate(controller.animation),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: appColor,
                            ))
                      ],
                    ).paddingSymmetric(vertical: margin_5),
                  ),
                  ExpandedSection(
                    child: HtmlWidget(
                      item?.answer ?? "",
                      textStyle: textStyleBody2()
                          .copyWith(color: blackLightColor, fontSize: font_16),
                    ),
                    expand: item!.isSelected,
                  )
                ],
              ).paddingSymmetric(vertical: margin_10);
            }).paddingSymmetric(horizontal: margin_5, vertical: margin_10);
  }
}
