/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class CommonCardViewDetail extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool? isBorder;
  final title;
  final image;
  final topView;
  final bottomButton;

  const CommonCardViewDetail({
    Key? key,
    this.child,
    this.padding,
    this.isBorder,
    this.title,
    this.image,
    this.topView,
    this.bottomButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin_15),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: isBorder == true ? appColor : Colors.transparent),
        borderRadius: BorderRadius.circular(radius_18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 3)
        ],
      ),
      child: Column(
        children: [
          topView ??
              Row(
                children: [
                  AssetImageWidget(
                    imageUrl: image,
                    imageHeight: height_20,
                    imageFitType: BoxFit.fill,
                  ).paddingOnly(right: margin_15),
                  TextView(
                      text: title,
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                ],
              ).paddingOnly(bottom: margin_5),
          topView ??
              Divider(
                color: Colors.grey.shade400,
              ).paddingSymmetric(vertical: margin_10),
          child!,
          bottomButton ?? Container()
        ],
      ),
    ).paddingOnly(bottom: margin_20, right: margin_5, left: margin_5,top: margin_5);
  }
}
