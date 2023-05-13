/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class CommonCardView extends StatelessWidget {
  final Widget? child;
  final double? padding;
  final bool? isBorder;
  final onPressed;
  BookingDetailDataModel? bookingDetailDataModel;

  CommonCardView({
    Key? key,
    this.child,
    this.padding,
    this.isBorder,
    this.onPressed,
    this.bookingDetailDataModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: getDateString(bookingDetailDataModel?.startTime ?? ""),
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
                  color: Colors.grey.shade200, blurRadius: 4,
                  spreadRadius: 3)
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(margin_20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius_20),
                    border: Border.all(color: appColor, width: 2)),
                child: NetworkImageWidget(
                  imageUrl:
                      bookingDetailDataModel?.patientDetail?.profileFile ?? "",
                  imageHeight: height_30,
                  errorImage: bookingDetailDataModel?.patientDetail?.gender==0?ICON_avatar:ICON_avatar_female,
                ),
              ).paddingOnly(right: margin_15),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  description(
                      descriptionHeading: strPaitentName,
                      descriptionSubHeading:
                          bookingDetailDataModel?.patientDetail?.fullName ??
                              ""),
                  description(
                      descriptionHeading: strPaitentAddress,
                      descriptionSubHeading:
                          bookingDetailDataModel?.patientDetail?.address ?? ""),
                  description(
                      descriptionHeading: strServicesCovered,
                      descriptionSubHeading:
                          '${bookingDetailDataModel?.serviceName ?? ""} -',

                      list: bookingDetailDataModel?.skillName?.toString().split(",")
                  ),
                  description(
                      descriptionHeading: strAppointDateTime,
                      descriptionSubHeading:
                          '${getDateString(bookingDetailDataModel?.startTime ?? "")}\n${getStartEndTIme(bookingDetailDataModel?.startTime ?? "", bookingDetailDataModel?.endTime ?? "")}'),
                  bookingDetailDataModel!.stateId ==statePending&&    bookingDetailDataModel?.userReschedule == userReschedule
                      ? buttonState("Rescheduled", appColor)
                      : bookingDetailDataModel!.stateId == stateCancelled
                          ? buttonState("Cancelled", redColor)
                          : bookingDetailDataModel!.stateId == stateInProgress
                              ? buttonState("In-Progress", appColor)
                              : bookingDetailDataModel!.stateId ==
                      stateCompleted
                                  ? buttonState("Completed", greenColor)
                                  : Container(),
                  SizedBox(height: height_10),
                  Get.find<AppointmentController>().isActive == 0
                      ? Container()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              vertical: margin_5, horizontal: margin_10),
                          decoration: BoxDecoration(
                              color: appColor,
                              borderRadius: BorderRadius.circular(radius_5)),
                          child: TextView(
                              text: strMoreDetails,
                              textStyle: TextStyle(
                                  fontSize: font_16, color: Colors.white)),
                        )
                ],
              )),
            ],
          ),
        ).paddingOnly(bottom: margin_25),
      ],
    );
  }

  buttonState(text, color) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Text(text, style: textStyleHeading2().copyWith(color: color)));
  }

  description({descriptionHeading, descriptionSubHeading,list}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading+'',
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                textAlign: TextAlign.start,
                maxLine: 4,
                text: descriptionSubHeading,
                textStyle: textStyleBody2().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_10),
        list==null?Container():
        ListView.builder(
            itemCount: list.length,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context,index){
              return
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.circle,color: Colors.black,size: margin_10).paddingOnly(right: margin_5),
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
