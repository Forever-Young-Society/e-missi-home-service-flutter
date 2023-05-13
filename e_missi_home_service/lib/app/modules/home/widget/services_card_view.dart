/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class ServicesCommonCardView extends StatelessWidget {
  final title;
  final index;

  final image;
  final color;
  final boxColor;

  // final int? index;

  const ServicesCommonCardView({
    Key? key,
    this.title,
    this.index,
    this.image,
    this.color,
    this.boxColor,
    // this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height_100,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              index == 0 ? Container() : Spacer(),
              Center(
                child: AssetImageWidget(imageUrl: image, imageHeight: height_60)
                    .paddingSymmetric(vertical: margin_3),
              ),
              index == 0
                  ? Container()
                  : Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: margin_15, vertical: margin_5),
                      child: Text(
                        strComingSoon,
                        textAlign: TextAlign.center,
                        style: textStyleBody2().copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: font_10),
                      ),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(radius_15),
                              bottomRight: Radius.circular(radius_15))),
                    )
            ],
          ),
          decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.circular(radius_15),
          ),
        ).paddingOnly(bottom: margin_7),
        Flexible(
          child: TextView(
            maxLine: 3,
            text: title,
            textAlign: TextAlign.center,
            textStyle: textStyleBody2()
                .copyWith(color: Colors.black, fontSize: font_12),
          ),
        ),
      ],
    );
  }
}
