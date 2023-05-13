/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class CommonCardView extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool? isBorder;

  const CommonCardView({
    Key? key,
    this.child,
    this.padding,
    this.isBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: '19 November 2022',
                textStyle: textStyleHeading().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_15),
        Container(
          padding: EdgeInsets.all(margin_15),
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                color: isBorder == true ? appColor : Colors.transparent),
            borderRadius: BorderRadius.circular(radius_18),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 3)
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AssetImageWidget(
                imageUrl: ic_girl,
                imageHeight: height_150,
                imageFitType: BoxFit.fill,
              ).paddingOnly(right: margin_15),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description(
                      descriptionHeading: strNursingService,
                      descriptionSubHeading: 'General health Assesment'),
                  description(
                      descriptionHeading: strTime,
                      descriptionSubHeading: '9:30 am - 11:30 am'),
                  description(
                      descriptionHeading: strPicMissi,
                      descriptionSubHeading: 'Ms. Rachel Wong'),
                  MaterialButtonWidget(
                    textColor: Colors.white,
                    fontsize: font_18,
                    buttonText: strRate,
                    padding: margin_3,
                    buttonRadius: margin_5,
                    onPressed: () {
                      Get.toNamed(AppRoutes.ratingScreen);
                    },
                    buttonColor: appColor,
                  ).marginOnly(right: margin_80, bottom: margin_10),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: TextView(
                          text: strMoreDetail,
                          textStyle:
                              textStyleBody2().copyWith(color: Colors.grey))),
                ],
              )),
            ],
          ),
        ).paddingOnly(bottom: margin_25),
      ],
    );
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: TextStyle(fontSize: font_14, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: descriptionSubHeading,
                textStyle: TextStyle(fontSize: font_14))
            .paddingOnly(bottom: margin_5),
      ],
    );
  }
}
