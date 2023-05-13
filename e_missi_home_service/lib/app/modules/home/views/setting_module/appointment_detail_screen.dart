/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentDetailScreen extends GetView<AppointmentDetailController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentDetailController>(
      init: AppointmentDetailController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () {
            if (controller.isNotified == true) {
              Get.offNamed(AppRoutes.mainScreen,
                  arguments: {'selectedIndex': 3});
              var controllers = Get.put(AppointmentController());
              controllers.isActive =
                  controller.bookingDetailResponseModel?.detail!.stateId ==
                          stateCompleted
                      ? 1
                      : 0;
              controllers.hitApiToGetBookingList(
                  controllers.isActive == 0
                      ? appointmentTypeUpcoming
                      : appointmentTypeHistory,
                  0);
              controllers.update();
            } else {
              if (controller.bookingDetailResponseModel!.detail != null) {
                Get.back(result: controller.bookingDetailResponseModel!.detail);
              } else {
                Get.back();
              }
            }
            return Future.value();
          },
          child: Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appBarView2(
                    title: strAppointment,
                    onTap: () {
                      if (controller.isNotified == true) {
                        Get.offNamed(AppRoutes.mainScreen,
                            arguments: {'selectedIndex': 3});
                        var controllers = Get.put(AppointmentController());
                        controllers.isActive = controller
                                    .bookingDetailResponseModel
                                    ?.detail!
                                    .stateId ==
                                stateCompleted
                            ? 1
                            : 0;
                        controllers.hitApiToGetBookingList(
                            controllers.isActive == 0
                                ? appointmentTypeUpcoming
                                : appointmentTypeHistory,
                            0);
                        controllers.update();
                      } else {
                        if (controller.bookingDetailResponseModel!.detail !=
                            null) {
                          Get.back(
                              result: controller
                                  .bookingDetailResponseModel!.detail);
                        } else {
                          Get.back();
                        }
                      }
                    }),
                Expanded(
                    child: CustomFutureBuilder(
                        future: controller.future,
                        widget: SingleChildScrollView(
                          child: Column(
                            children: [
                              paitentDetailsCard(),
                              nurseDetails(),
                              appointmentsDetails(),
                              _resheduled(),
                              controller.bookingDetailResponseModel?.detail!
                                          .stateId ==
                                      statePending
                                  ? _buttons()
                                  : controller.bookingDetailResponseModel?.detail!
                                              .stateId ==
                                  stateCancel
                                      ? buttonState("cancelled", redColor)
                                      : controller.bookingDetailResponseModel
                                                  ?.detail!.stateId ==
                                              stateInProgress
                                          ? buttonState("In-Progress", appColor)
                                          : Container()
                            ],
                          ),
                        )))
              ],
            ).paddingSymmetric(horizontal: margin_15),
          ),
        );
      },
    );
  }

  paitentDetailsCard() {
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
            imageHeight: height_90,
            imageFitType: BoxFit.fill,
            errorImage: controller.bookingDetailResponseModel?.detail
                        ?.patientDetail?.gender ==
                    0
                ? ICON_avatar
                : ICON_avatar_female,
          ).paddingOnly(right: margin_15),
          Expanded(
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
                      "0"),
              description(
                  descriptionHeading: strGender,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                              ?.detail?.patientDetail?.gender ==
                          0
                      ? 'Male'
                      : 'Female'),
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
    ).marginSymmetric(horizontal: margin_5, vertical: margin_15);
  }

  nurseDetails() {
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
            imageHeight: height_90,
            imageFitType: BoxFit.fill,
            errorImage: controller.bookingDetailResponseModel?.detail
                        ?.providerDetail?.gender ==
                    0
                ? ICON_avatar
                : ICON_avatar_female,
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
                  descriptionHeading: strAges,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                          ?.detail?.providerDetail?.age
                          ?.toString() ??
                      ""),
              description(
                  descriptionHeading: strGender,
                  descriptionSubHeading: controller.bookingDetailResponseModel
                              ?.detail?.providerDetail?.gender ==
                          0
                      ? 'Male'
                      : 'Female'),
              description(
                  descriptionHeading: strExperience,
                  descriptionSubHeading:
                      '${controller.bookingDetailResponseModel?.detail?.providerDetail?.experience?.toString() ?? "0"} Years'),
              description(
                  descriptionHeading: strContactNo,
                  descriptionSubHeading: ''
                      '${controller.bookingDetailResponseModel?.detail?.providerDetail?.contactNo?.toString() ?? ""}'),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
              ]).paddingOnly(bottom: margin_10),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse(
                      "tel://${controller.bookingDetailResponseModel?.detail?.providerDetail?.contactNo ?? ""}"));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: darkPurple,
                      borderRadius: BorderRadius.circular(radius_5)),
                  padding: EdgeInsets.symmetric(
                      vertical: margin_5, horizontal: margin_10),
                  child: TextView(
                    text: strContactNow,
                    textStyle:
                        TextStyle(fontSize: font_13, color: Colors.white),
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    ).marginSymmetric(horizontal: margin_5);
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
              list: controller.bookingDetailResponseModel?.detail?.skillName
                  .toString()
                  .split(','),
              descriptionSubHeading:
                  "${controller.bookingDetailResponseModel?.detail?.serviceName ?? ""}:-"),
          appointmentsDescription(
              descriptionHeading: strAddress,
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

  _resheduled() {
    return controller.bookingDetailResponseModel?.detail?.userReschedule !=
                null &&
            controller.bookingDetailResponseModel?.detail?.userReschedule ==
                userReschdeule
        ? Align(
            alignment: Alignment.bottomRight,
            child: TextView(
              text: "Rescheduled",
              textStyle: TextStyle(fontSize: font_13, color: appColor),
            ).paddingOnly(bottom: margin_20),
          )
        : Container();
  }

  _buttons() {
    return Column(
      children: [
        controller.button == true ? Container() : reschedule(),
        controller.button == true ? Container() : canceAppointment()
      ],
    );
  }

  reschedule() {
    return MaterialButtonWidget(
      buttonColor: appColor,
      textColor: Colors.white,
      buttonText: strReschedule,
      fontsize: font_18,
      onPressed: () async {
        var date = DateTime.parse(
                controller.bookingDetailResponseModel!.detail!.startTime)
            .subtract(Duration(hours: 12));
        if (DateTime.now().isBefore(date)) {
          Get.delete<AppointmentCalendarController>();
          var data =
              await Get.toNamed(AppRoutes.appointmentViewRoute, arguments: {
            'categoryId': controller
                .bookingDetailResponseModel?.detail?.skillDetail?.categoryId,
            'bookingStartTime':
                controller.bookingDetailResponseModel?.detail?.startTime,
            'bookingId': controller.bookingDetailResponseModel?.detail?.id,
            'date': controller.bookingDetailResponseModel?.detail?.startTime,
            'providerId': controller
                .bookingDetailResponseModel?.detail?.providerDetail?.id,
            "serviceId":
                controller.bookingDetailResponseModel?.detail?.serviceId,
            'dependentId': controller
                .bookingDetailResponseModel?.detail?.patientDetail?.id,
            'typeId': controller.bookingDetailResponseModel?.detail?.typeId,
            'type': 'Update',
            'isFirst': true
          });
          if (data != null) {
            controller.future = data;
          }
          controller.update();
        } else {
          alertDialog(
              alert: true,
              text: strUnableToReschedule,
              onTap: () {
                Get.back();
              });
        }
      },
    ).paddingOnly(bottom: margin_10, top: margin_10);
  }

  canceAppointment() {
    return MaterialButtonWidget(
      buttonColor: Colors.grey.shade400,
      borderColor: Colors.grey.shade400,
      textColor: Colors.white,
      buttonText: strCancelAppointment,
      fontsize: font_18,
      onPressed: () {
        var date = DateTime.parse(
                controller.bookingDetailResponseModel!.detail!.startTime)
            .subtract(Duration(hours: 12));

        if (DateTime.now().isBefore(date)) {
          logoutDialog(
              text: strCancelAppintmentDescription,
              confirmText: strConfirm,
              onTap: () {
                Get.back();
                logoutDialog(
                    textfeild: true,
                    controller: controller.reasonController,
                    text: strCancellationReason,
                    confirmText: strSubmit,
                    onCancel: () {
                      controller.reasonController.clear();
                      Get.back();
                    },
                    onTap: () {
                      controller.cancelAppointmentApiCall();
                    });
              });
        } else {
          alertDialog(
              alert: true,
              text: strUnableToCancel,
              onTap: () {
                Get.back();
              });
        }
      },
    ).paddingOnly(bottom: margin_10);
  }

  buttonState(title, color) {
    return MaterialButtonWidget(
      buttonColor: color,
      borderColor: Colors.grey.shade400,
      textColor: Colors.white,
      buttonText: title,
      fontsize: font_18,
      onPressed: () {},
    ).paddingOnly(bottom: margin_10);
  }

  appointmentsDescription({descriptionHeading, descriptionSubHeading, list}) {
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
                      Icon(Icons.circle, color: Colors.grey, size: margin_10)
                          .paddingOnly(right: margin_5),
                      Expanded(
                        child: TextView(
                            textAlign: TextAlign.start,
                            maxLine: 5,
                            text: list[index],
                            textStyle:
                                textStyleBody2().copyWith(color: Colors.grey)),
                      )
                    ],
                  ).paddingOnly(bottom: margin_10);
                })
      ],
    );
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading + ' : ',
                textStyle: TextStyle(fontSize: font_12, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Flexible(
            child: TextView(
                    text: descriptionSubHeading,
                    textStyle: TextStyle(fontSize: font_12))
                .paddingOnly(bottom: margin_10)),
      ],
    );
  }
}
