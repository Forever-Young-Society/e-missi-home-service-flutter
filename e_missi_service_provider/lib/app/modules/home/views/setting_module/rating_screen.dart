/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class RatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _body();
  }

/*========================================================_body============================================*/

  _body() => GetBuilder<RatingController>(
        init: RatingController(),
        builder: (controller) {
          return Scaffold(
            body: CustomFutureBuilder(
              future: controller.future,
              widget: SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appBarView2(title: strMyRatingReview),
                      bodyWidegt(controller),
                      controller.loadMore == true
                          ? Padding(
                              padding: EdgeInsets.only(bottom: height_0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                      color: appColor)),
                            )
                          : Container()
                    ]).paddingSymmetric(
                    horizontal: margin_20, vertical: margin_5),
              ),
            ),
          );
        },
      );

  bodyWidegt(RatingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        imageWidget(controller),
        Center(
                child: TextView(
                    text: controller.loginResponseModel?.detail?.fullName ?? "",
                    textStyle:
                        textStyleHeading2().copyWith(color: Colors.black)))
            .paddingOnly(bottom: margin_5),
        rateAndReview(controller),
        TextView(
                text: strSortBy,
                textStyle: textStyleBody2()
                    .copyWith(color: Colors.black, fontSize: font_18))
            .paddingOnly(bottom: margin_15),
        tabss(controller),
        controller.ratingList != null && controller.ratingList.length != 0
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return commentView(controller.ratingList[index]);
                },
                itemCount: controller.ratingList.length,
              )
            : Center(
                child: Text("No rating has been given yet",
                    style: textStyleTitle().copyWith(color: Colors.grey)),
              )
      ],
    );
  }

  divider() {
    return Divider(
      color: Colors.grey,
    ).paddingOnly(bottom: margin_10);
  }

  commentView(RatingDataModel list) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NetworkImageWidget(
              imageUrl: list.userImage ?? "",
              imageHeight: height_60,
              errorImage:
                  list.userGender == 0 ? ICON_avatar : ICON_avatar_female,
            ).paddingOnly(right: margin_10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                          text: list.userName ?? "",
                          textStyle: textStyleHeading2()
                              .copyWith(color: Colors.black, fontSize: font_16))
                      .paddingOnly(bottom: margin_5),
                  TextView(
                          textAlign: TextAlign.start,
                          maxLine: 5,
                          text:
                              '${list.serviceName ?? ""} - ${list.skillName ?? ""}',
                          textStyle: textStyleBody2()
                              .copyWith(color: Colors.grey, fontSize: font_16))
                      .paddingOnly(bottom: margin_5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      rateingBar(list),
                      Flexible(
                        child: TextView(
                                maxLine: 7,
                                text: list.createdOn ?? "",
                                textStyle: textStyleHeading2().copyWith(
                                    color: Colors.grey, fontSize: font_16))
                            .paddingOnly(bottom: margin_5),
                      ),
                    ],
                  ),
                  TextView(
                          textAlign: TextAlign.start,
                          maxLine: 6,
                          text: list.comment ?? "",
                          textStyle: textStyleHeading2()
                              .copyWith(color: Colors.grey, fontSize: font_16))
                      .paddingOnly(bottom: margin_5)
                ],
              ),
            )
          ],
        ).paddingOnly(bottom: margin_15),
        divider()
      ],
    );
  }

  imageWidget(controller) {
    return Center(
      child: NetworkImageWidget(
        imageUrl: controller.loginResponseModel?.detail?.profileFile ?? "",
        imageHeight: height_130,
        errorImage: controller.loginResponseModel?.detail?.gender == 0
            ? ICON_avatar
            : ICON_avatar_female,
      ),
    ).paddingOnly(bottom: margin_15, top: margin_20);
  }

  tabss(controller) {
    return Row(
      children: [
        latestTabs(controller),
        highestTabs(controller),
        lowestTabs(controller),
      ],
    ).paddingOnly(right: margin_30, bottom: margin_20);
  }

  latestTabs(RatingController controller) {
    return Flexible(
      child: InkWell(
        onTap: () {
          controller.isActive = sortLatest;
          controller.pageNum = 0;
          controller.future = controller.hitRatingListApi(sortLatest, 0);
          controller.update();
          debugPrint(controller.isActive.toString());
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
          alignment: Alignment.center,
          child: TextView(
              text: strLatest,
              textStyle: textStyleBody2().copyWith(
                  color: controller.isActive == sortLatest
                      ? Colors.white
                      : Colors.grey,
                  fontSize: font_15)),
          decoration: BoxDecoration(
              color: controller.isActive == sortLatest ? appColor : whiteColor,
              borderRadius: BorderRadius.circular(radius_25),
              border: Border.all(
                  color: controller.isActive == sortLatest
                      ? Colors.transparent
                      : Colors.grey,
                  width: width_1)),
        ),
      ).paddingOnly(right: margin_10),
    );
  }

  highestTabs(RatingController controller) {
    return Flexible(
      child: InkWell(
        onTap: () {
          controller.isActive = sortHighest;
          controller.pageNum = 0;
          controller.future = controller.hitRatingListApi(sortHighest, 0);

          controller.update();
          debugPrint(controller.isActive.toString());
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
          alignment: Alignment.center,
          child: TextView(
              text: strHighest,
              textStyle: textStyleBody2().copyWith(
                  color: controller.isActive == sortHighest
                      ? Colors.white
                      : Colors.grey,
                  fontSize: font_15)),
          decoration: BoxDecoration(
              color: controller.isActive == sortHighest ? appColor : whiteColor,
              borderRadius: BorderRadius.circular(radius_25),
              border: Border.all(
                  color: controller.isActive == sortHighest
                      ? Colors.transparent
                      : Colors.grey,
                  width: width_1point5)),
        ),
      ).paddingOnly(right: margin_10),
    );
  }

  lowestTabs(RatingController controller) {
    return Flexible(
      child: InkWell(
        onTap: () {
          controller.isActive = sortLowest;
          controller.pageNum = 0;
          controller.future = controller.hitRatingListApi(sortLowest, 0);

          controller.update();
          debugPrint(controller.isActive.toString());
        },
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_10),
          alignment: Alignment.center,
          child: TextView(
              text: strLowest,
              textStyle: textStyleBody2().copyWith(
                  color: controller.isActive == sortLowest
                      ? Colors.white
                      : Colors.grey,
                  fontSize: font_15)),
          decoration: BoxDecoration(
              color: controller.isActive == sortLowest ? appColor : whiteColor,
              borderRadius: BorderRadius.circular(radius_25),
              border: Border.all(
                  color: controller.isActive == sortLowest
                      ? Colors.transparent
                      : Colors.grey,
                  width: width_1point5)),
        ),
      ),
    );
  }

  rateAndReview(controller) {
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
                  text: controller.loginResponseModel?.detail?.rating ?? "0",
                  style: textStyleHeading2()
                      .copyWith(color: Colors.black, fontSize: font_15)),
              TextSpan(
                  text:
                      '( ${controller.ratingList.length.toString() ?? "0"} reviews)',
                  style: textStyleBody2()
                      .copyWith(color: Colors.grey, fontSize: font_15)),
            ],
          ),
        )
      ],
    ).paddingOnly(bottom: margin_15);
  }

  rateingBar(RatingDataModel list) {
    return RatingBar(
      initialRating: list.rating.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemSize: height_20,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
        full: AssetImageWidget(imageUrl: ic_star),
        empty: AssetImageWidget(
          imageUrl: ic_emptyStart,
        ),
        half: Container(),
      ),
      itemPadding: EdgeInsets.symmetric(horizontal: margin_0),
      onRatingUpdate: (rating) {},
    ).paddingOnly(bottom: margin_15, right: margin_5);
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
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: 'Write your comment...',
            hintStyle: textStyleBody2().copyWith(color: Colors.black38)),
      ),
    );
  }

  rateButton() {
    return MaterialButtonWidget(
      buttonColor: appColor,
      onPressed: () {},
      buttonText: strRateNow,
      buttonRadius: radius_5,
      fontsize: font_16,
    ).paddingSymmetric(horizontal: margin_10, vertical: margin_15);
  }
}
