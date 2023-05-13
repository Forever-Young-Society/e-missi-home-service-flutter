/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class AppointmentCalendarScreen extends GetView<AppointmentCalendarController> {
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          return Future.value(true);
        },
        child: GetBuilder<AppointmentCalendarController>(
          init: AppointmentCalendarController(),
          builder: (controller) {
            return Scaffold(body: _bodyWidget());
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
              appBarView2(title: strAppointment),
              _calendar(controller),
              selectedView(),
              contactView(),
              Spacer(),
              _buttonView(),
            ],
          ).paddingSymmetric(horizontal: margin_20, vertical: margin_25),
        ],
      );

  _calendar(AppointmentCalendarController controller) =>
      GetBuilder<AppointmentCalendarController>(
          init: AppointmentCalendarController(),
          builder: (controller) {
            return Container(
                height: Get.height * 0.45,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  allowViewNavigation: false,
                  showNavigationArrow: true,
                  minDate: controller.startDate,
                  maxDate: controller.lastDate,
                  todayHighlightColor: Colors.transparent,
                  headerHeight: height_50,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs dates) {
                    controller.selectedDays.clear();
                    controller.selectedDays1.clear();
                    controller.selectedDays.add(dates.value);
                    controller.selectedDays.last.forEach((element) {
                      if (controller.selectedDays1
                          .contains(sendDate(dateString: element.toString()))) {
                        controller.selectedDays1
                            .remove(sendDate(dateString: element.toString()));
                      } else {
                        controller.selectedDays1
                            .add(sendDate(dateString: element.toString()));
                      }
                    });
                    controller.update();
                  },
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1,
                    blackoutDates: controller.blackOutDays,
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: font_20,
                          fontWeight: FontWeight.w600)),
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  selectionShape: DateRangePickerSelectionShape.rectangle,
                  selectionColor: appColor,
                  selectionRadius: radius_20,
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

  _buttonView() {
    return MaterialButtonWidget(
      buttonColor: Colors.grey.shade400,
      borderColor: Colors.grey.shade400,
      onPressed: () {
        bottomSheet(
            widget: Container(
          height: height_300,
          decoration: BoxDecoration(
              color: appLightColor,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(margin_25))),
          child: bottomSheetView(),
        ));
      },
      buttonText: strProceedToNextStep.toUpperCase(),
    );
  }

  bottomSheetView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strTime,
                  style:
                      TextStyle(fontSize: font_18, fontWeight: FontWeight.bold))
              .paddingOnly(top: margin_5, bottom: margin_10),
          _gridView(),
          _sheetButtonView()
        ],
      ).paddingAll(margin_10),
    );
  }

  _gridView() {
    return GetBuilder<AppointmentCalendarController>(builder: (controller) {
      return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.gridItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
              childAspectRatio: 3.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.selectedIndex = index;
                controller.update();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius_10),
                    color: controller.selectedIndex == index
                        ? appColor
                        : Colors.white),
                child: Center(
                    child: Text(
                  controller.gridItems[index],
                  style: TextStyle(
                      color: controller.selectedIndex == index
                          ? Colors.white
                          : blackColor),
                )),
              ),
            );
          });
    });
  }

  _sheetButtonView() {
    return MaterialButtonWidget(
      onPressed: () {},
      buttonText: strBookNow.toUpperCase(),
    ).paddingOnly(top: margin_20);
  }
}
