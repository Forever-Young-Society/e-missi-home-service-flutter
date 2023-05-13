/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:e_missi_service_provider/export.dart';

class MyBusinessCalendarScreen extends GetView<MyBusinessCalendarController> {
  final serviceType = new GlobalKey(debugLabel: 'serviceType');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyBusinessCalendarController>(
      init: MyBusinessCalendarController(),
      builder: (MyBusinessCalendarController controller) {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AssetImageWidget(
                imageUrl: ic_tech_bg,
                imageFitType: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appBarView2(title: strMyCalendar),
                  Expanded(
                      child: Column(
                    children: [
                      cardView(),
                      _calendar(controller),
                      controller.selectedDate==null?
                          Container():
                      selectedView()
                    ],
                  )),
                ],
              ).paddingSymmetric(horizontal: margin_15),
            ],
          ),
        );
      },
    );
  }

  cardView() {
    return Card(
      elevation: margin_5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius_15)),
      child: _commonField(
          title: strService, hint: strSelectService, readOnly: true),
    ).paddingOnly(top: margin_20);
  }

  _commonField({hint, title, suffix, focusNode, readOnly, maxline, prefix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: title,
                textStyle:
                    TextStyle(fontSize: font_16, fontWeight: FontWeight.w600))
            .paddingOnly(bottom: margin_5),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: margin_0,
                bottom: margin_5,
              ),
              child: TextFieldWidget(
                hint: hint ?? "",
                maxline: maxline ?? 1,
                minLine: maxline ?? 1,
                focusNode: focusNode,
                textController: controller.serviceController,
                alignLabelWithHint: false,
                labels: false,
                onTap: () {
                  openDropdown(serviceType);
                  controller.update();
                },
                readOnly: readOnly ?? false,
                hintStyle: textStyleBody1()
                    .copyWith(fontSize: font_14, color: Colors.grey.shade400),
                contentPadding: EdgeInsets.symmetric(
                    horizontal: margin_10, vertical: margin_15),
                borders: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(margin_10),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
                suffixIcon: suffix ??
                    AssetImageWidget(
                      imageUrl: ic_dropdown,
                      imageHeight: height_15,
                      imageWidth: height_15,
                      color: Colors.purple,
                    ).paddingAll(margin_12),
                prefixIcon: prefix,
              ).paddingOnly(bottom: margin_20),
            ),
            Positioned(
              bottom: -10,
              left: 20,
              right: 25,
              child: Container(
                width: margin_50,
                height: margin_0,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CategoryDataModel>(
                    menuMaxHeight: 200,
                    borderRadius: BorderRadius.circular(radius_10),
                    key: serviceType,
                    iconEnabledColor: Colors.transparent,
                    items: (controller.categoryList)
                        ?.map((CategoryDataModel value) {
                      return DropdownMenuItem<CategoryDataModel>(
                        value: value,
                        child: Container(
                            child: Text(
                          value.title.toString(),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey.shade400),
                        )),
                      );
                    }).toList(),
                    onChanged: (temp) {
                      controller.serviceController?.text = temp!.title;
                      controller.selectedCategory = temp!.id;
                      if (controller.selectedDate != null) {
                        controller.slotsListAPI();
                      }
                      controller.update();
                    },
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ).paddingOnly(
        right: margin_10, left: margin_10, top: margin_15, bottom: margin_0);
  }

  _calendar(MyBusinessCalendarController controller) =>
      GetBuilder<MyBusinessCalendarController>(
          init: MyBusinessCalendarController(),
          builder: (controller) {
            return Container(
                height: Get.height * 0.45,
                child: SfDateRangePicker(
                  view: DateRangePickerView.month,
                  showNavigationArrow: true,
                  minDate: controller.startDate,
                  maxDate: controller.lastDate,
                  todayHighlightColor: Colors.transparent,
                  headerHeight: height_50,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs dates) {
                        controller.selectedDate = dates.value;
                        if (controller.selectedCategory != null) {
                      controller.slotsListAPI();
                      controller.update();
                    } else {
                      flashBar(message: strPleasAddServices);
                    }
                        controller.update();
                  },
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1,
                  ),
                  headerStyle: DateRangePickerHeaderStyle(
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: font_20,
                          fontWeight: FontWeight.w600)),
                  selectionMode: DateRangePickerSelectionMode.single,
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
                )).paddingOnly(top: margin_20);
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
      ],
    );
  }
}
