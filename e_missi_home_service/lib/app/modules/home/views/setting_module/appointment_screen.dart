/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class AppointmentScreen extends GetView<AppointmentController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      init: AppointmentController(),
      builder: (controller) {
        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            tabss(controller),
            Expanded(
                child: CustomFutureBuilder(
              future: controller.future,
              widget: controller.bookingList.length == 0
                  ? _listEmptyWidget(controller)
                  : _bookingList(controller),
            ))
          ],
        ));
      },
    );
  }

  _listEmptyWidget(controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextView(
                maxLine: 2,
                text: controller.isActive == 0
                    ? strYouDonthaveAnyUpcoming
                    : strYouDonthaveAnyHistory,
                textStyle: textStyleBody1().copyWith(color: Colors.black))
            .paddingOnly(bottom: margin_15),
        MaterialButtonWidget(
          onPressed: () {
            Get.toNamed(AppRoutes.homeServiceScreenRoute);
          },
          fontsize: font_20,
          buttonText: strBookAnAppointmentNow,
        ).marginSymmetric(horizontal: margin_25)
      ],
    );
  }

  _bookingList(AppointmentController controller) {
    return Column(
      children: [
        SizedBox(height: height_20),
        Expanded(
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.bookingList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  if (controller.bookingList[index].stateId != stateCompleted) {
                    var data =
                        await Get.toNamed(AppRoutes.appointmentDetailScreen,
                            arguments: AppArguments.appointmentDetailData(
                              bookingId: controller.bookingList[index].id,
                              isNotified: false,
                            ));
                    if (data != null) {
                      if (data.runtimeType.toString() ==
                          "BookingDetailDataModel") {
                        controller.bookingList[index] = data;
                      } else {
                        controller.isActive = data;
                        controller.pageNum = 0;
                        controller.future = controller.hitApiToGetBookingList(
                            controller.isActive == 0
                                ? appointmentTypeUpcoming
                                : appointmentTypeHistory,
                            controller.pageNum);
                      }
                    }
                    controller.update();
                  } else {
                    Get.toNamed(AppRoutes.appointmentDetailScreen, arguments: AppArguments.appointmentDetailData(
                            bookingId: controller.bookingList[index].id,
                            isNotified: false,
                            rate: controller.bookingList[index].stateId !=
                                    stateCompleted
                                ? false
                                : true));
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                            text: getDateString(
                                controller.bookingList[index].startTime ?? ""),
                            textStyle: textStyleHeading()
                                .copyWith(color: Colors.black))
                        .paddingOnly(bottom: margin_15),
                    Container(
                      padding: EdgeInsets.all(margin_15),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(radius_18),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4,
                              spreadRadius: 3)
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NetworkImageWidget(
                            imageUrl: controller.bookingList[index]
                                    .providerDetail?.profileFile ??
                                "",
                            imageHeight: height_100,
                            imageFitType: BoxFit.fill,
                          ).paddingOnly(right: margin_15),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              description(
                                  descriptionHeading:
                                      "${controller.bookingList[index].serviceName ?? ""} :",
                                  descriptionSubHeading:
                                      "${controller.bookingList[index].skillName ?? ""}",
                                  list: controller.bookingList[index].skillName
                                      .toString()
                                      .split(',')),
                              description(
                                  descriptionHeading: strTime + " :",
                                  descriptionSubHeading: getStartEndTIme(
                                      controller.bookingList[index].startTime ??
                                          "",
                                      controller.bookingList[index].endTime ??
                                          "")),
                              description(
                                  descriptionHeading: "",
                                  descriptionSubHeading: controller
                                          .bookingList[index]
                                          .providerDetail
                                          ?.qualificationTitle ??
                                      ""),
                              controller.bookingList[index].stateId !=
                                      stateCompleted
                                  ? Container()
                                  : controller.bookingList[index].isRating ==
                                          false
                                      ? MaterialButtonWidget(
                                          textColor: Colors.white,
                                          fontsize: font_18,
                                          buttonText: strRate,
                                          padding: margin_3,
                                          buttonRadius: margin_5,
                                          onPressed: () async {
                                            var data = await Get.toNamed(
                                                AppRoutes.ratingScreen,
                                                arguments: {
                                                  'detail': controller
                                                      .bookingList[index]
                                                });
                                            if (data != null) {
                                              print("object${data}");
                                              controller.bookingList[index]
                                                  .isRating = data;
                                            }
                                            controller.update();
                                          },
                                          buttonColor: appColor,
                                        ).marginOnly(
                                          right: margin_80, bottom: margin_10)
                                      : Container(),
                              controller.bookingList[index].stateId ==
                                          statePending &&
                                      controller.bookingList[index]
                                              .userReschedule ==
                                          userReschdeule
                                  ? buttonState("Rescheduled", appColor)
                                  : controller.bookingList[index].stateId ==
                                          stateCancel
                                      ? buttonState("cancelled", redColor)
                                      : controller.bookingList[index].stateId ==
                                              stateInProgress
                                          ? buttonState("In-Progress", appColor)
                                          : Container(),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextView(
                                      text: strMoreDetail,
                                      textStyle: textStyleBody2()
                                          .copyWith(color: Colors.grey))),
                            ],
                          )),
                        ],
                      ),
                    ).paddingOnly(bottom: margin_25),
                  ],
                ).marginSymmetric(horizontal: margin_15),
              );
            },
          ),
        ),
        controller.loadMore == true
            ? Padding(
                padding: EdgeInsets.only(bottom: height_0),
                child:
                    Center(child: CircularProgressIndicator(color: appColor)),
              )
            : Container(),
      ],
    );
  }

  buttonState(text, color) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Text(text, style: textStyleHeading2().copyWith(color: color))
            .paddingSymmetric(vertical: margin_5));
  }

  description({descriptionHeading, descriptionSubHeading, list}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: TextStyle(fontSize: font_14, color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        list == null
            ? TextView(
                    text: descriptionSubHeading,
                    maxLine: 5,
                    textAlign: TextAlign.start,
                    textStyle: TextStyle(fontSize: font_14))
                .paddingOnly(bottom: margin_5)
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
                })
      ],
    );
  }

  /*============================================_bodyWidget==========================================*/

  Widget tabss(AppointmentController controller) {
    return Container(
      height: height_50,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () {
              controller.isActive = 0;
              controller.pageNum = 0;
              controller.future = controller.hitApiToGetBookingList(
                  appointmentTypeUpcoming, controller.pageNum);
              controller.update();
              debugPrint(controller.isActive.toString());
            },
            child: Container(
              alignment: Alignment.center,
              height: height_50,
              decoration: BoxDecoration(
                color:
                    controller.isActive == 0 ? appColor : Colors.grey.shade200,
              ),
              child: TextView(
                  text: strUpcoming,
                  textStyle: Theme.of(Get.context!)
                      .textTheme
                      .headline1!
                      .copyWith(
                          fontSize: font_18,
                          fontWeight: FontWeight.w500,
                          color: controller.isActive == 0
                              ? Colors.white
                              : Colors.black)),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              controller.isActive = 1;
              controller.pageNum = 0;
              controller.future = controller.hitApiToGetBookingList(
                  appointmentTypeHistory, controller.pageNum);

              controller.update();
              debugPrint(controller.isActive.toString());
            },
            child: Container(
              alignment: Alignment.center,
              height: height_50,
              decoration: BoxDecoration(
                color:
                    controller.isActive == 1 ? appColor : Colors.grey.shade200,
              ),
              child: TextView(
                  text: strHistory,
                  textStyle: Theme.of(Get.context!)
                      .textTheme
                      .headline1!
                      .copyWith(
                          fontSize: font_18,
                          fontWeight: FontWeight.w500,
                          color: controller.isActive == 1
                              ? Colors.white
                              : Colors.black)),
            ),
          )),
        ],
      ),
    ).paddingOnly(top: margin_15, bottom: margin_0);
  }
}
