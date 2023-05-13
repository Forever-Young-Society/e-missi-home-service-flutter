/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class AppointmentDetailConfirmationScreen
    extends GetView<AppointmentDetailConfirmationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentDetailConfirmationController>(
      init: AppointmentDetailConfirmationController(),
      builder: (AppointmentDetailConfirmationController controller) {
        return WillPopScope(
          onWillPop: () {
            Get.deleteAll(force: true);
            Get.offNamed(AppRoutes.mainScreen);
            return Future.value();
          },
          child: Scaffold(
            body: CustomFutureBuilder(
              future: controller.future,
              widget: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AssetImageWidget(
                    imageUrl: ic_tech_bg,
                    imageFitType: BoxFit.cover,
                  ),
                  Column(
                    children: [
                      appBarView2(title: strAppointmentDetailsConfirmation),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _commonCard1(),
                              _commonCard2(),
                              _commonCard3(),
                              _commonButton(),
                            ],
                          ).paddingSymmetric(vertical: margin_5),
                        ),
                      )
                    ],
                  ).paddingSymmetric(horizontal: margin_15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _commonCard1() {
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
            imageHeight: height_100,
            imageFitType: BoxFit.fill,
          ).paddingOnly(right: margin_15),
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
                  descriptionHeading: 'Age',
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.patientDetail?.age
                          ?.toString() ??
                      ""),
              description(
                  descriptionHeading: strGender,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                              ?.detail?.patientDetail?.gender ==
                          0
                      ? 'Male'
                      : 'Female'),
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

  _commonCard2() {
    return CommonCardViewDetail(
      title: strNurseDetails,
      image: ic_doctor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NetworkImageWidget(
            imageUrl: controller.bookingDetailResponseModel?.detail
                    ?.providerDetail?.profileFile ??
                "",
            imageHeight: height_100,
            imageFitType: BoxFit.fill,
          ).paddingOnly(right: margin_15),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                      text: controller.bookingDetailResponseModel?.detail
                              ?.providerDetail?.fullName ??
                          "",
                      textStyle: textStyleBody2().copyWith(color: Colors.black))
                  .paddingOnly(bottom: margin_5),
              description(
                  descriptionHeading: 'Age',
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.providerDetail?.age
                          ?.toString() ??
                      ""),
              description(
                  descriptionHeading: 'Gender',
                  descriptionSubHeading: controller.bookingDetailResponseModel
                              ?.detail?.providerDetail?.gender ==
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
                      text: controller.bookingDetailResponseModel?.detail
                              ?.providerDetail?.rating
                              ?.toString() ??
                          "0",
                      textStyle: textStyleHeading2()
                          .copyWith(color: Colors.black, fontSize: font_15))
                ],
              )
            ],
          )),
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  _commonCard3() {
    return CommonCardViewDetail(
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
              descriptionSubHeading: controller.bookingDetailResponseModel
                      ?.detail?.patientDetail?.address ??
                  ""),
          appointmentsDescription(
              descriptionHeading: strDateTime,
              descriptionSubHeading: controller.getDate(
                  controller.bookingDetailResponseModel?.detail?.startTime ??
                      "",
                  controller.bookingDetailResponseModel?.detail?.endTime ??
                      "")),
          InkWell(
            onTap: () {
              Get.delete<AppointmentCalendarController>();
              Get.toNamed(AppRoutes.appointmentViewRoute, arguments: {
                'categoryId': controller.bookingDetailResponseModel?.detail
                    ?.skillDetail?.categoryId,
                'bookingId': controller.bookingDetailResponseModel?.detail?.id,
                'date':
                    controller.bookingDetailResponseModel?.detail?.startTime,
                'providerId': controller
                    .bookingDetailResponseModel?.detail?.providerDetail?.id,
                "serviceId":
                    controller.bookingDetailResponseModel?.detail?.serviceId,
                'dependentId': controller
                    .bookingDetailResponseModel?.detail?.patientDetail?.id,
                'typeId': controller.bookingDetailResponseModel?.detail?.typeId,
                'type': 'Update',
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: margin_15, vertical: margin_7),
              child: TextView(
                text: strEdit,
                textStyle: textStyleBody2().copyWith(color: Colors.grey),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(radius_5),
                  border: Border.all(color: Colors.grey)),
            ),
          )
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
  }

  _commonButton() {
    return MaterialButtonWidget(
      buttonColor: appColor,
      textColor: Colors.white,
      buttonText: strConfirmProceed,
      fontsize: font_18,
      onPressed: () {
        Get.toNamed(AppRoutes.orderServicesScreen, arguments: {
          "bookingId": controller.bookingDetailResponseModel?.detail?.id,
          "orderId": controller.bookingDetailResponseModel?.detail?.orderId
        });
      },
    ).paddingOnly(bottom: margin_10, top: margin_10);
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: TextStyle(fontSize: font_12, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: ': ',
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
            Get.deleteAll(force: true);
            Get.offNamed(AppRoutes.mainScreen);
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
            Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: font_26, color: purple))
                .paddingOnly(
              left: margin_10,
            ),
          ],
        ),
      ],
    ).paddingOnly(bottom: margin_15, top: margin_35);
  }
}
