/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';


class PaymentServicesScreen extends GetView<PaymentServicesController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentServicesController>(
      init: PaymentServicesController(),
      builder: (PaymentServicesController controller) {
        return Scaffold(
            body: CustomFutureBuilder(
          future: controller.future,
          widget: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AssetImageWidget(
                imageUrl: ic_tech_bg,
                imageFitType: BoxFit.cover,
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appBarView2(title: strOrderServicesSummary),
                    CommonCardViewDetail(
                      title: strPatientDetails,
                      image: ic_profile,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NetworkImageWidget(
                            imageUrl: controller.bookingDetailResponseModel
                                    ?.detail?.patientDetail?.profileFile ??
                                "",
                            imageHeight: height_100,
                            imageFitType: BoxFit.fill,
                          ).paddingOnly(right: margin_15),
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                      text: controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.patientDetail
                                              ?.fullName ??
                                          "",
                                      textStyle: textStyleBody2()
                                          .copyWith(color: Colors.black))
                                  .paddingOnly(bottom: margin_5),
                              description(
                                  descriptionHeading: 'Age',
                                  descriptionSubHeading: controller
                                          .bookingDetailResponseModel
                                          ?.detail
                                          ?.patientDetail
                                          ?.age
                                          ?.toString() ??
                                      "0"),
                              description(
                                  descriptionHeading: strGender,
                                  descriptionSubHeading: controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.patientDetail
                                              ?.gender ==
                                          0
                                      ? 'Male'
                                      : 'Female'),
                              description(
                                  descriptionHeading: strDateofBirth,
                                  descriptionSubHeading: getDateString(
                                      controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.patientDetail
                                              ?.dateOfBirth ??
                                          "")),
                              description(
                                  descriptionHeading: strICNo,
                                  descriptionSubHeading: controller
                                          .bookingDetailResponseModel
                                          ?.detail
                                          ?.patientDetail
                                          ?.identityNumber ??
                                      ""),
                              description(
                                  descriptionHeading: strContactNo,
                                  descriptionSubHeading: controller
                                          .bookingDetailResponseModel
                                          ?.detail
                                          ?.patientDetail
                                          ?.contactNo ??
                                      ""),
                            ],
                          )),
                        ],
                      ),
                    ).marginSymmetric(horizontal: margin_5),
                    CommonCardViewDetail(
                      title: strNurseDetails,
                      image: ic_doctor,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NetworkImageWidget(
                            imageUrl: controller.bookingDetailResponseModel
                                    ?.detail?.providerDetail?.profileFile ??
                                "",
                            imageHeight: height_100,
                            imageFitType: BoxFit.fill,
                          ).paddingOnly(right: margin_15),
                          Flexible(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextView(
                                      text: controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.providerDetail
                                              ?.fullName ??
                                          "",
                                      textStyle: textStyleBody2()
                                          .copyWith(color: Colors.black))
                                  .paddingOnly(bottom: margin_5),
                              description(
                                  descriptionHeading: strAges,
                                  descriptionSubHeading: controller
                                          .bookingDetailResponseModel
                                          ?.detail
                                          ?.providerDetail
                                          ?.age
                                          ?.toString() ??
                                      ""),
                              description(
                                  descriptionHeading: strGender,
                                  descriptionSubHeading: controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.providerDetail
                                              ?.gender ==
                                          0
                                      ? 'Male'
                                      : 'Female'),
                              description(
                                  descriptionHeading: strExperience,
                                  descriptionSubHeading:
                                      '${controller.bookingDetailResponseModel?.detail?.providerDetail?.experience?.toString() ?? "0"} Years'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AssetImageWidget(
                                    imageUrl: ic_star,
                                    imageHeight: height_20,
                                  ).paddingOnly(
                                    right: margin_5,
                                  ),
                                  TextView(
                                      text: controller
                                              .bookingDetailResponseModel
                                              ?.detail
                                              ?.providerDetail
                                              ?.rating
                                              ?.toString() ??
                                          "0",
                                      textStyle: textStyleHeading2().copyWith(
                                          color: Colors.black,
                                          fontSize: font_15))
                                ],
                              )
                            ],
                          )),
                        ],
                      ),
                    ).marginSymmetric(horizontal: margin_5),
                    CommonCardViewDetail(
                      title: strAppointmentsDetails,
                      image: ic_date,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appointmentsDescription(
                              descriptionHeading: strTypesofService,
                              descriptionSubHeading:
                                  "${controller.bookingDetailResponseModel?.detail?.serviceName ?? ""}:- ${controller.bookingDetailResponseModel?.detail?.skillDetail?.title ?? ""}"),
                          appointmentsDescription(
                              descriptionHeading: strAddress,
                              descriptionSubHeading: controller
                                      .bookingDetailResponseModel
                                      ?.detail
                                      ?.patientDetail
                                      ?.address ??
                                  ""),
                          appointmentsDescription(
                              descriptionHeading: strDateTime,
                              descriptionSubHeading: controller.getDate(
                                  controller.bookingDetailResponseModel?.detail
                                          ?.startTime ??
                                      "",
                                  controller.bookingDetailResponseModel?.detail
                                          ?.endTime ??
                                      "")),
                        ],
                      ),
                    ).marginSymmetric(horizontal: margin_5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                                text:
                                    '${strOrderId} ${controller.bookingDetailResponseModel?.detail?.id}',
                                textStyle: textStyleHeading2()
                                    .copyWith(color: Colors.black))
                            .paddingOnly(bottom: margin_10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                                text: '${strItems}',
                                textStyle: textStyleBody3().copyWith(
                                    color: Colors.grey, fontSize: font_16)),
                            TextView(
                                text: '${strPrice}',
                                textStyle: textStyleBody3().copyWith(
                                    color: Colors.grey, fontSize: font_16)),
                          ],
                        ).paddingOnly(bottom: margin_10),
                        orderdescription(
                            title:
                                'Booking - ${controller.getDateString(controller.bookingDetailResponseModel?.detail?.startTime ?? "")}',
                            value:
                                'RM ${double.parse(controller.bookingDetailResponseModel?.detail?.skillDetail?.userPrice ?? "0.00").toStringAsFixed(2)}'),
                        // orderdescription(
                        //     title: 'Service Tax (6%)', value: 'RM 30.00'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextView(
                                text: strTotal,
                                textStyle: textStyleHeading2().copyWith(
                                  color: Colors.black,
                                )),
                            TextView(
                                text:
                                    'RM ${double.parse(controller.bookingDetailResponseModel?.detail?.skillDetail?.userPrice ?? "0.00").toStringAsFixed(2)}',
                                textStyle: textStyleHeading().copyWith(
                                    color: Colors.black, fontSize: font_17)),
                          ],
                        ).paddingOnly(bottom: margin_10, top: margin_10),
                      ],
                    ).paddingSymmetric(horizontal: margin_10),
                  ],
                ).paddingSymmetric(horizontal: margin_15),
              ),
            ],
          ),
        ));
      },
    );
  }

  orderdescription({title, value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextView(
            text: title,
            textStyle: textStyleBody2().copyWith(
              color: Colors.grey,
            )),
        TextView(
            text: value,
            textStyle: textStyleBody2().copyWith(
              color: Colors.grey,
            )),
      ],
    ).paddingOnly(bottom: margin_5);
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading + " :  ",
                textStyle: TextStyle(fontSize: font_12, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Expanded(
            child: TextView(
                    text: descriptionSubHeading,
                    textAlign: TextAlign.start,
                    maxLine: 2,
                    textStyle: TextStyle(fontSize: font_12))
                .paddingOnly(bottom: margin_10)),
      ],
    );
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

  appBarView2({title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.offAllNamed(AppRoutes.mainScreen);
          },
          child: AssetImageWidget(
            imageUrl: ic_back_image,
            imageFitType: BoxFit.cover,
            imageHeight: height_25,
          ).paddingOnly(bottom: margin_10),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: font_26, color: purple))
                  .paddingOnly(
                left: margin_10,
              ),
            ),
          ],
        ),
      ],
    ).paddingOnly(bottom: margin_15, top: margin_35);
  }
}
