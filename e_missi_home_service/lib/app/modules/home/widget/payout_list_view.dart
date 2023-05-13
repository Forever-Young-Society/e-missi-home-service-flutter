/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class PayOutView extends StatelessWidget {
  final String? title;
  final Color borderColor;

  const PayOutView({
    Key? key,
    this.title,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_50),
        border: Border.all(color: borderColor),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade300, blurRadius: 4, spreadRadius: 3)
        ],
      ),
      child: ListTile(
        dense: true,
        isThreeLine: false,
        leading: AssetImageWidget(imageUrl: ic_default, imageHeight: height_40),
        title: TextView(
          text: "$strOrderId : #12345",
          textStyle: textStyleBody1(),
          textAlign: TextAlign.start,
        ),
        trailing: TextView(
            text: "+\$30",
            textStyle: textStyleBody1().copyWith(color: greenColor)),
        subtitle: TextView(
            text: "Jan/03/2022 at 11:57",
            textAlign: TextAlign.start,
            textStyle: textStyleSubTitle2().copyWith(
              color: Colors.grey,
            )),
      ),
    ).marginOnly(
        top: margin_15, bottom: margin_5, right: margin_2, left: margin_2);
  }
}
