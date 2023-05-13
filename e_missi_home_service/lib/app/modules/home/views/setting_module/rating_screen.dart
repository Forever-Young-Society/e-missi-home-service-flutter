/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class RatingScreen extends GetView<RatingController> {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appBarView2(title: strAddDependent),
            bodyWidegt()

            // formWidget(),
          ],
        ).paddingSymmetric(horizontal: margin_20, vertical: margin_5),
      );

  bodyWidegt() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageWidget(),
            Center(
                    child: TextView(
                        text: controller.bookingDetailDataModel?.providerDetail
                                ?.fullName ??
                            "",
                        textStyle:
                            textStyleHeading2().copyWith(color: Colors.black)))
                .paddingOnly(bottom: margin_5),
            rateAndReview(),
            Center(
                    child: TextView(
                        maxLine: 2,
                        text: strHowWouldYouRate,
                        textStyle: textStyleBody2()
                            .copyWith(color: Colors.black, fontSize: font_16)))
                .paddingOnly(bottom: margin_5),
            rateingBar(),
            TextView(
                    maxLine: 2,
                    text: strCaretoShareMore,
                    textStyle: textStyleBody2()
                        .copyWith(color: Colors.black, fontSize: font_25))
                .paddingOnly(bottom: margin_5),
            TextView(
                maxLine: 2,
                text: strHowWasYouOverallExperience,
                textStyle: textStyleBody1().copyWith(
                  color: Colors.grey,
                )).paddingOnly(bottom: margin_15),
            commnetBox(),
            rateButton(),
          ],
        ),
      ),
    );
  }

  imageWidget() {
    return Center(
      child: NetworkImageWidget(
        imageUrl:
            controller.bookingDetailDataModel?.providerDetail?.profileFile ??
                "",
        imageHeight: height_130,
        errorImage:
            controller.bookingDetailDataModel?.providerDetail?.gender == 0
                ? ICON_avatar
                : ICON_avatar_female,
      ),
    ).paddingOnly(bottom: margin_15);
  }

  rateAndReview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AssetImageWidget(
          imageUrl: ic_star,
          imageHeight: height_20,
        ).paddingOnly(
          right: margin_10,
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: controller
                          .bookingDetailDataModel?.providerDetail?.rating
                          ?.toString() ??
                      "",
                  style: textStyleHeading2()
                      .copyWith(color: Colors.black, fontSize: font_15)),
              TextSpan(
                  text:
                      '( ${controller.bookingDetailDataModel?.providerDetail?.ratingCount ?? "0"} reviews)',
                  style: textStyleBody2()
                      .copyWith(color: Colors.grey, fontSize: font_15)),
            ],
          ),
        )
      ],
    ).paddingOnly(bottom: margin_15);
  }

  rateingBar() {
    return Center(
      child: RatingBar(
        initialRating: 1,
        minRating: 1,
        direction: Axis.horizontal,
        itemCount: 5,
        itemSize: height_45,
        ratingWidget: RatingWidget(
          full: AssetImageWidget(imageUrl: ic_star),
          empty: AssetImageWidget(
            imageUrl: ic_emptyStart,
          ),
          half: Container(),
        ),
        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        onRatingUpdate: (rating) {
          controller.updateRate(rating);
        },
      ),
    ).paddingOnly(bottom: margin_15);
  }

  commnetBox() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(margin_10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(radius_8)),
      child: TextField(
        maxLines: 7,
        minLines: 7,
        maxLength: 100,
        controller: controller.commentController,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Add maximum 100 Characters...",
            hintStyle: textStyleBody2().copyWith(color: Colors.black38)),
      ),
    );
  }

  rateButton() {
    return MaterialButtonWidget(
      buttonColor: appColor,
      onPressed: () {
        controller.hitApiToGiveRate();
      },
      buttonText: strRateNow,
      buttonRadius: radius_5,
      fontsize: font_16,
    ).paddingSymmetric(horizontal: margin_10, vertical: margin_15);
  }

  appBarView2({title, onTap}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onTap ??
                    () {
                      Get.back();
                    },
                child: AssetImageWidget(
                  imageUrl: ic_back_image,
                  imageFitType: BoxFit.cover,
                  imageHeight: height_25,
                ).paddingOnly(bottom: margin_10),
              ),
            ],
          ),
        ],
      ),
    ).paddingOnly(top: margin_20);
  }
}
