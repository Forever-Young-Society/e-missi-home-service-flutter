/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AppointmentCalendarScreen extends StatelessWidget {
  final controller = Get.put(AppointmentCalendarController());

  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Get.delete<AppointmentCalendarController>();
          Get.back();
          return Future.value(true);
        },
        child: GetBuilder<AppointmentCalendarController>(
          init: AppointmentCalendarController(),
          builder: (controller) {
            return Scaffold(
                body: controller.isOk
                    ? _bodyWidget()
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitChasingDots(color: Colors.red),
                            SizedBox(
                              height: height_10,
                            ),
                            TextView(
                                text: strFindingSlots,
                                textStyle: textStyleBody1()),
                          ],
                        ),
                      ));
          },
        ));
  }

  /* ==================================================== build body of the screen =========================================================*/

  Widget _bodyWidget() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AssetImageWidget(
            imageUrl: ic_tech_bg,
            imageFitType: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarView2(
                  title: strAppointment,
                  onTap: () {
                    Get.delete<AppointmentCalendarController>();
                    Get.back();
                  }),
              _calendar(),
              selectedView(),
              contactView(),
              Spacer(),
            ],
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_25),
        ],
      );

  _calendar() => GetBuilder<AppointmentCalendarController>(
      init: AppointmentCalendarController(),
      builder: (controller) {
        return Container(
            height: Get.height * 0.45,
            child: Stack(
              children: [
                SfDateRangePicker(
                  controller: controller.dateRangePickerController,
                  view: DateRangePickerView.month,
                  showNavigationArrow: false,

                  allowViewNavigation: false,
                  navigationMode: DateRangePickerNavigationMode.none,
                  minDate: controller.minDate,
                  selectableDayPredicate: (day) {
                    return controller.availableSet!.contains(day);
                  },
                  enablePastDates: false,
                  maxDate: controller.lastDate,
                  selectionMode: DateRangePickerSelectionMode.single,
                  onViewChanged: controller.viewChanged,
                  todayHighlightColor: Colors.transparent,
                  headerHeight: height_50,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs dates) {
                    controller.selectedIndex=null;
                    controller.slotId=null;
                    controller.selectedDate = dates.value;
                    controller.date = DateFormat('yyyy-MM-dd')
                        .format(DateTime.parse(dates.value.toString()));

                     if(controller.isFirst==false)
                       {
                         controller.hitProviderSlotApi(controller.selectedDate,
                         rescheduleTime: controller.bookingStartTime);
                         controller.isFirst=true;
                       }
                  controller.update();
                    debugPrint(controller.date);},
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1,
                    blackoutDates: controller.blackoutDates,
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: font_20,
                          fontWeight: FontWeight.w600)),
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  initialSelectedDate: DateTime.parse(controller.selDate),
                  selectionColor: appColor,
                  initialSelectedDates: [],
                  selectionRadius: radius_20,
                  initialDisplayDate: DateTime.tryParse(controller.date),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                      blackoutDatesDecoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(radius_10)),
                      textStyle: TextStyle(
                          fontSize: font_14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      disabledDatesTextStyle: TextStyle(
                          fontSize: font_14, color: Colors.grey.shade400),
                      todayTextStyle:
                          TextStyle(fontSize: font_14, color: Colors.black),
                      blackoutDateTextStyle:
                          TextStyle(fontSize: font_14, color: Colors.white)),
                ),
                Positioned(
                    left: 1.0,
                    right: 1.0,
                    top: 15.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.startDate!
                                  .isAfter(controller.minDate!)) {
                                controller.isOk = false;

                                controller.hitProviderAvailibilityListApi(
                                    providerId: controller.providerId,
                                    dateMonth: DateFormat("yyyy-MM").format(
                                        controller.startDate!
                                            .subtract(Duration(days: 31))),
                                    serviceId: controller.catId,
                                    isForward: false);
                              }
                              controller.update();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: height_25,
                            )),
                        InkWell(
                            onTap: () {
                              if (controller.startDate!.year !=
                                  controller.lastDate!.year) {
                                if (controller.startDate!.month <=
                                    controller.lastDate!.month) {
                                  controller.isOk = false;
                                  controller.hitProviderAvailibilityListApi(
                                      providerId: controller.providerId,
                                      dateMonth: DateFormat("yyyy-MM").format(
                                          controller.startDate!
                                              .add(Duration(days: 31))),
                                      serviceId: controller.catId,
                                      isForward: true);
                                }
                              } else {
                                if (controller.startDate!.month <
                                    controller.lastDate!.month) {
                                  controller.isOk = false;
                                  controller.hitProviderAvailibilityListApi(
                                      providerId: controller.providerId,
                                      dateMonth: DateFormat("yyyy-MM").format(
                                          controller.startDate!
                                              .add(Duration(days: 31))),
                                      serviceId: controller.catId,
                                      isForward: true);
                                }
                              }
                              controller.update();
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: height_25,
                            ))
                      ],
                    ))
              ],
            ));
      });

  selectedView() {
    return Row(
      children: [
        Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: appColor),
                width: height_12,
                height: height_12)
            .paddingOnly(right: margin_5),
        Text(strSelected,
                style: TextStyle(fontSize: font_14, color: blackLightColor))
            .paddingOnly(right: margin_20),
        Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: redColor),
                width: height_12,
                height: height_12)
            .paddingOnly(right: margin_5),
        Text(strNotAvailable,
            style: TextStyle(fontSize: font_14, color: blackLightColor)),
      ],
    );
  }

  contactView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssetImageWidget(
          imageUrl: ic_bulb_image,
          imageFitType: BoxFit.cover,
          imageHeight: height_25,
        ).paddingOnly(right: margin_5),
        Expanded(
            child: Text(strContactSlot,
                style: TextStyle(fontSize: font_14, color: blackLightColor),
                maxLines: 2)),
      ],
    ).paddingOnly(top: margin_10);
  }
}
