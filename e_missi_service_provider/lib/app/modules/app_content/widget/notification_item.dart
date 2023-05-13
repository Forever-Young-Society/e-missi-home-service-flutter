/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class NotificationItemView extends StatelessWidget {
  final String? imageUrl;
  final String? heading;
  final String? description;
  final String? time;

  const NotificationItemView({
    Key? key,
    this.imageUrl,
    this.heading,
    this.description,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bodyItem();
  }

  bodyItem() => CommonCardView(
        child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: AssetImageWidget(
              imageUrl: imageUrl!,
              imageWidth: height_50,
              imageHeight: height_50,
            ).paddingOnly(top: margin_7, left: margin_10),
            title: TextView(
              text: heading!,
              textStyle: textStyleBody1().copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
              maxLine: 2,
            ),
            subtitle: TextView(
              text: description!,
              maxLine: 2,
              textAlign: TextAlign.justify,
              textStyle: textStyleBody2().copyWith(
                  color: Colors.grey,
                  fontSize: font_15,
                  fontWeight: FontWeight.w500),
            )).paddingSymmetric(vertical: margin_8),
      );
}
