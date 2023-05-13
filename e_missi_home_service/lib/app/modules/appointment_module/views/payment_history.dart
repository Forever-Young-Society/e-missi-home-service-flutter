/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class PaymentHistoryScreen extends GetView<PaymentHistoryController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentHistoryController>(
      init: PaymentHistoryController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appBarView2(
                title: strPaymentHistory,
              ),
              Expanded(
                  child: CustomFutureBuilder(
                      future: controller.future,
                      widget: controller.historyList?.length == 0
                          ? Center(
                              child: Text(strNoBookingsFound,
                                  style: textStyleTitle()
                                      .copyWith(color: Colors.grey)),
                            )
                          : ListView.builder(
                              itemCount: controller.historyList?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var item = controller.historyList?[index];
                                return appointmentsDetails(item);
                              },
                            )))
            ],
          ).paddingSymmetric(horizontal: margin_15),
        );
      },
    );
  }

  appointmentsDetails(PaymentHistoryDataModel? item) {
    return CommonCardViewDetail(
      title: "Order ID: ${item?.orderId}",
      image: ic_date,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          bookingInfo(
              title:
                  "Booking - ${getDateString(item?.startTime?.toString() ?? "")}",
              subTitle: "RM ${item?.userAmount?.toString() ?? ""}"),
          bookingInfo(
            title:
                "Paid On - ${getDateString(item?.createdOn?.toString() ?? "")}",
          ),
          Divider(
            color: Colors.grey.shade400,
          ).paddingSymmetric(vertical: margin_10),
          bookingInfo(
              title: strOrderTotal,
              subTitle: "RM ${item?.userAmount?.toString() ?? ""}",
              color: appColor),
          _buttonView(item)
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  bookingInfo({title, subTitle, color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        subTitle == null
            ? Container()
            : Text(subTitle, style: TextStyle(color: color ?? Colors.grey)),
      ],
    ).paddingSymmetric(vertical: margin_5);
  }

  _buttonView(PaymentHistoryDataModel? item) {
    return Row(
      children: [
        Spacer(),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.appointmentDetailScreen,
                arguments: AppArguments.appointmentDetailData(
                    bookingId: item?.id, isNotified: false, rate: true));
          },
          child: Container(
            decoration: BoxDecoration(
                color: appColor, borderRadius: BorderRadius.circular(radius_5)),
            child: Text(
              strDetails,
              style: TextStyle(color: Colors.white),
            ).paddingSymmetric(vertical: margin_8, horizontal: margin_30),
          ),
        ),
      ],
    ).paddingOnly(top: margin_5);
  }
}
