/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class BookingHistoryDetailScreen
    extends GetView<BookingHistoryDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingHistoryDetailController>(
      init: BookingHistoryDetailController(),
      builder: (BookingHistoryDetailController controller) {
        return Scaffold(
          body: CustomFutureBuilder(
            future: controller.future,
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBarView2(title: ''),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        paitentDetails(),
                        appointmentsDetails(),
                        paymentDetails()
                      ],
                    ),
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: margin_15),
          ),
        );
      },
    );
  }

  appointmentsDetails() {
    return CommonCardViewDetail(
      title: strAppointmentsDetails,
      image: ic_date,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appointmentsDescription(
              descriptionHeading: strTypesofService,
              descriptionSubHeading:
                  controller.bookingDetailResponseModel?.detail?.serviceName ??
                      ""),
          appointmentsDescription(
              descriptionHeading: strAddressW,
              descriptionSubHeading: controller.bookingDetailResponseModel
                      ?.detail?.patientDetail?.address ??
                  ""),
          appointmentsDescription(
              descriptionHeading: strDateTime,
              descriptionSubHeading: getDate(
                  controller.bookingDetailResponseModel?.detail?.startTime ??
                      "",
                  controller.bookingDetailResponseModel?.detail?.endTime ??
                      "")),
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  appointmentsDescription({descriptionHeading, descriptionSubHeading}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading + ' :',
                textStyle: textStyleBody2().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_3),
        TextView(
                textAlign: TextAlign.start,
                maxLine: 5,
                text: descriptionSubHeading,
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_15),
      ],
    );
  }

  paitentDetails() {
    return CommonCardViewDetail(
      title: strPatientDetails,
      image: ic_profile,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageWidget(
            imageUrl: controller.bookingDetailResponseModel?.detail
                    ?.patientDetail?.profileFile ??
                "",
            imageHeight: height_80,
            imageFitType: BoxFit.fill,
          ).paddingOnly(right: margin_5),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                      text: controller.bookingDetailResponseModel?.detail
                              ?.patientDetail?.fullName ??
                          "",
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_5),
              description(
                  descriptionHeading: strage,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.patientDetail?.age
                          ?.toString() ??
                      ""),
              description(
                  descriptionHeading: strGender,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                              ?.detail?.patientDetail?.gender ==
                          0
                      ? strMale
                      : strFemale),
              description(
                  descriptionHeading: strDateofBirth,
                  descriptionSubHeading: getDateString(controller
                          .bookingDetailResponseModel
                          ?.detail
                          ?.patientDetail
                          ?.dateOfBirth ??
                      "")),
              description(
                  descriptionHeading: strICNo,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.patientDetail?.identityNumber ??
                      ""),
              description(
                  descriptionHeading: strContactNo,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.patientDetail?.contactNo ??
                      ""),
            ],
          )),
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading + ' : ',
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Expanded(
            child: TextView(
                    text: descriptionSubHeading,
                    textAlign: TextAlign.start,
                    maxLine: 2,
                    textStyle: textStyleBody2().copyWith(color: Colors.black))
                .paddingOnly(bottom: margin_10)),
      ],
    );
  }

  paymentDetails() {
    return CommonCardViewDetail(
      title: strPaymentDetails,
      image: ic_paymentt,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paymentDescription(
              descriptionHeading: strOrderIdd,
              descriptionSubHeading: controller
                      .bookingDetailResponseModel?.detail?.id
                      ?.toString() ??
                  "",
              color: Colors.grey),
          paymentDescription(
              descriptionHeading: strOrderStatus,
              descriptionSubHeading: controller
                          .bookingDetailResponseModel?.detail!.stateId ==
                      stateCancelled
                  ? strCancelled
                  : controller.bookingDetailResponseModel?.detail!.stateId ==
                          stateInProgress
                      ? strInProgress
                      : controller.bookingDetailResponseModel?.detail!
                                  .stateId ==
                              stateCompleted
                          ? strCompleted
                          : strPending),
          paymentDescription(
              descriptionHeading: strPaymentStatus,
              descriptionSubHeading:
                  '${controller.bookingDetailResponseModel?.detail?.paymentStatus == paymentSuccess ? strSUCCESS : controller.bookingDetailResponseModel?.detail?.paymentStatus == paymentPending ? strPENDING : strFAILED}',
              color: controller
                          .bookingDetailResponseModel?.detail?.paymentStatus ==
                      paymentSuccess
                  ? greenColor
                  : appColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                      text: '${strPaymentAmount} :',
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_3),
              Flexible(
                  child: TextView(
                          text:
                              'RM ${controller.bookingDetailResponseModel?.detail?.skillDetail?.providerPrice ?? "0"}',
                          textStyle:
                              textStyleHeading2().copyWith(color: Colors.black))
                      .paddingOnly(bottom: margin_10)),
            ],
          )
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  paymentDescription({descriptionHeading, descriptionSubHeading, color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: textStyleBody2().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: ":  ",
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Flexible(
            child: TextView(
                    text: descriptionSubHeading,
                    textStyle: textStyleBody2().copyWith(color: color))
                .paddingOnly(bottom: margin_10)),
      ],
    );
  }
}
