/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MyBookingHistoryScreen extends GetView<MyBookingHistoryController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBookingHistoryController>(
      init: MyBookingHistoryController(),
      builder: (MyBookingHistoryController controller) {
        return Scaffold(
          body: CustomFutureBuilder(
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarView2(title: strMyBookingHistory),
                SizedBox(height: height_20),
                Expanded(
                  child: controller.bookingList != null &&
                          controller.bookingList.length != 0
                      ? ListView.separated(
                          itemCount: controller.bookingList.length,
                          padding: EdgeInsets.symmetric(
                              horizontal: margin_10, vertical: margin_20),
                          itemBuilder: (BuildContext context, int index) {
                            return bookingFunction(index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: margin_15,
                            );
                          },
                        )
                      : Center(
                          child: Text(strNoBookingsFound,
                              style: textStyleTitle()
                                  .copyWith(color: Colors.grey)),
                        ),
                ),
                controller.loadMore == true
                    ? Padding(
                        padding: EdgeInsets.only(bottom: height_0),
                        child: Center(
                            child: CircularProgressIndicator(color: appColor)),
                      )
                    : Container(),
              ],
            ).paddingSymmetric(horizontal: margin_10),
            future: controller.future,
          ),
        );
      },
    );
  }

  bookingFunction(index) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius_18),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 3)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookigTitle(index),
          description(
              descriptionHeading: strOrderIdd,
              descriptionSubHeading:
                  controller.bookingList[index].id?.toString() ?? "",
              colour: Colors.grey),
          description(
              descriptionHeading: strDateTime,
              descriptionSubHeading:
                  getDateString(controller.bookingList[index].startTime ?? ""),
              colour: Colors.grey),
          divider(),
          description(
              descriptionHeading: strPaymentStatus,
              descriptionSubHeading:
                  '${controller.bookingList[index].paymentStatus == paymentSuccess ? strSUCCESS : controller.bookingList[index].paymentStatus == paymentPending ? strPENDING : strFAILED}',
              colour:
                  controller.bookingList[index].paymentStatus == paymentSuccess
                      ? greenColor
                      : appColor),
          divider(),
          viewdetailsButton(index),
        ],
      ),
    );
  }

  bookigTitle(index) {
    return TextView(
            textAlign: TextAlign.start,
            maxLine: 3,
            text: '${controller.bookingList[index].serviceName ?? ""} - \n'
                '${controller.bookingList[index].skillDetail?.title ?? ""} ',
            textStyle: textStyleHeading2().copyWith(
              color: Colors.black,
            ))
        .paddingOnly(
            top: margin_15,
            bottom: margin_10,
            left: margin_15,
            right: margin_15);
  }

  viewdetailsButton(index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.bookingHistoryDetailScreen,
            arguments: {"bookingId": controller.bookingList[index].id});
      },
      child: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: margin_20, vertical: margin_10),
        child: TextView(
          text: strViewDetails,
          textStyle: textStyleBody1().copyWith(
            color: Colors.white,
          ),
        ),
        decoration: BoxDecoration(
            color: appColor, borderRadius: BorderRadius.circular(radius_5)),
      ).paddingOnly(
          bottom: margin_15, top: margin_10, left: margin_20, right: margin_20),
    );
  }

  divider() {
    return Divider(
      color: Colors.grey.shade300,
    ).paddingOnly(bottom: margin_10);
  }

  description({descriptionHeading, descriptionSubHeading, colour}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: textStyleBody1()
                    .copyWith(color: Colors.grey, fontSize: font_14))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: ': ',
                textStyle: textStyleBody1()
                    .copyWith(color: Colors.grey, fontSize: font_14))
            .paddingOnly(bottom: margin_3),
        Flexible(
            child: TextView(
                    text: descriptionSubHeading,
                    textStyle: textStyleBody1()
                        .copyWith(color: colour, fontSize: font_14))
                .paddingOnly(bottom: margin_10)),
      ],
    ).paddingSymmetric(horizontal: margin_15);
  }
}
