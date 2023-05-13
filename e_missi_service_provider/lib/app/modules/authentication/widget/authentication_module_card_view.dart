/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AuthCardView extends StatelessWidget {
  final Widget? child;
  final double? height;

  const AuthCardView({this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
            child: child,
            height: height,
            padding: EdgeInsets.symmetric(
                horizontal: margin_20, vertical: margin_10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius_20),
                gradient: LinearGradient(
                    colors: [appColor, loginBoxGradient],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)))
        .marginOnly(
      top: margin_10,
    );
  }
}

backGroundContainer() {
  return Center(
    child: Container(
      height: height_10,
      margin: EdgeInsets.only(left: margin_20, right: margin_20),
      decoration: BoxDecoration(
          color: loginBoxBack,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(radius_30),
              bottomLeft: Radius.circular(radius_30))),
    ),
  );
}

appBarView({title, isHideBAck, onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      isHideBAck ??
          InkWell(
            onTap: onTap ??
                () {
                  Get.back();
                },
            child: AssetImageWidget(
              imageUrl: ic_back_image,
              imageFitType: BoxFit.cover,
              imageHeight: height_20,
            ).paddingOnly(bottom: margin_0),
          ),
      Text(title,
              style: TextStyle(fontSize: font_27, fontWeight: FontWeight.w400))
          .paddingOnly(left: margin_10),
    ],
  ).paddingOnly(top: margin_30);
}

appBarView2({title,onTap}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        onTap:onTap?? () {
          Get.back();
        },
        child: AssetImageWidget(
          imageUrl: ic_back_image,
          imageFitType: BoxFit.cover,
          imageHeight: height_25,
        ).paddingOnly(bottom: margin_10),
      ),
      Center(
        child: Text(title, style: TextStyle(fontSize: font_26, color: appColor))
            .paddingOnly(left: margin_10),
      ),
    ],
  ).paddingOnly(top: margin_30);
}
