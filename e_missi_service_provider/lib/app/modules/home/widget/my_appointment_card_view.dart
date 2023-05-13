/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MyAppointmentsCommonCardView extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool? isBorder;
  var ontap;
  BookingDetailDataModel? bookingList;

  MyAppointmentsCommonCardView({
    Key? key,
    this.child,
    this.padding,
    this.isBorder,
    this.ontap,
    this.bookingList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: getDateString(bookingList?.startTime ?? ""),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              description(
                  descriptionHeading: strPaitentName,
                  descriptionSubHeading: bookingList?.patientDetail?.fullName
                          ?.toString()
                          .trimLeft() ??
                      "",
                  color: blackColor),
              description(
                  descriptionHeading: strPaitentAddress,
                  descriptionSubHeading:
                      bookingList?.patientDetail?.address ?? "",
                  color: blackColor),
              description(
                  descriptionHeading: strServicesCovered,
                  descriptionSubHeading: '${bookingList?.serviceName ?? ""}',
                  color: blackColor,
                  list: bookingList?.skillName?.toString().split(",.")),
              description(
                  descriptionHeading: strAppointDateTime,
                  descriptionSubHeading:
                      '${getDateString(bookingList?.startTime ?? "")}\n${getStartEndTIme(bookingList?.startTime ?? "", bookingList?.endTime ?? "")}',
                  color: blackColor),
              description(
                  descriptionHeading: strStatus,
                  descriptionSubHeading: bookingList?.stateId == statePending
                      ? strPending
                      : bookingList?.stateId == stateInProgress
                          ? strOnDuty
                          : strCompleted,
                  color: bookingList?.stateId == statePending
                      ? Colors.yellow
                      : bookingList?.stateId == stateInProgress
                          ? redColor
                          : greenColor),
              bookingList!.stateId == statePending ||
                      bookingList!.stateId == stateInProgress
                  ? button(onTap: () {
                      ontap();
                    })
                  : Container(),
            ],
          ),
        ).paddingOnly(bottom: margin_25),
      ],
    );
  }

  button({onTap}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: margin_8),
        width: Get.width,
        alignment: Alignment.center,
        child: TextView(
          text: bookingList?.stateId == stateInProgress
              ? strEndDuty
              : strStartDuty,
          textStyle: bookingList?.stateId == stateInProgress
              ? TextStyle(fontSize: font_12, color: Colors.white)
              : textStyleHeading2().copyWith(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: appColor, borderRadius: BorderRadius.circular(radius_5)),
      ).marginOnly(bottom: margin_10),
    );
  }

  description({descriptionHeading, descriptionSubHeading, color, list}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                textAlign: TextAlign.start,
                maxLine: 4,
                text: descriptionSubHeading,
                textStyle: textStyleBody2().copyWith(color: color))
            .paddingOnly(bottom: margin_10),
        list == null
            ? Container()
            : ListView.builder(
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.circle, color: Colors.black, size: margin_10)
                          .paddingOnly(right: margin_5),
                      Expanded(
                        child: TextView(
                            textAlign: TextAlign.start,
                            maxLine: 5,
                            text: list[index],
                            textStyle: textStyleBody2().copyWith()),
                      )
                    ],
                  ).paddingOnly(bottom: margin_5);
                }).paddingOnly(bottom: margin_5)
      ],
    );
  }
}
