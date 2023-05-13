
import '../../../../export.dart';

class SelectSlotScreen extends GetView<AppointmentCalendarController> {
  var type;

  SelectSlotScreen({this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: appLightColor,
        height: Get.height * 0.4,
        child: bottomSheetView());
  }

  bottomSheetView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(strTime,
                style:
                    TextStyle(fontSize: font_18, fontWeight: FontWeight.bold))
            .paddingOnly(top: margin_5, bottom: margin_10),
        Expanded(
          child: SingleChildScrollView(
            child: _gridView(),
          ),
        ),
        _sheetButtonView()
      ],
    ).paddingAll(margin_10);
  }

  _gridView() {
    return GetBuilder<AppointmentCalendarController>(builder: (controller) {
      return controller.mySlotList != null && controller.mySlotList!.length != 0
          ? GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.mySlotList?.length ?? 0,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 3.0),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (controller.mySlotList![index].isBooked == false) {
                      controller.selectedIndex = index;
                      controller.getSlotID(
                          controller.mySlotList![index].id,
                          controller.mySlotList![index].startTime,
                          controller.mySlotList![index].endTime);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius_5),
                        color: controller.selectedIndex == index
                            ? appColor
                            : Colors.white),
                    child: Center(
                        child: controller.mySlotList?[index].slotShowtype == 1
                            ? Text(
                                "${convertDateToNormalTime(dateString: "${controller.mySlotList?[index].startTime.toString()}")}",
                                style: TextStyle(
                                    color: controller.selectedIndex == index
                                        ? Colors.white
                                        : controller.mySlotList![index]
                                                    .isBooked ==
                                                true
                                            ? Colors.grey
                                            : blackColor),
                              )
                            : Text(
                                "${convertDateToNormalTime(dateString: "${controller.mySlotList?[index].startTime.toString()}")} - ${convertDateToNormalTime(dateString: "${controller.mySlotList?[index].endTime.toString()}")}",
                                style: TextStyle(
                                    color: controller.selectedIndex == index
                                        ? Colors.white
                                        : controller.mySlotList![index]
                                                    .isBooked ==
                                                true
                                            ? Colors.grey
                                            : blackColor),
                              )),
                  ),
                );
              })
          : Center(
              child: Text(strNoslotsavailable,
                  style: textStyleTitle().copyWith(color: Colors.grey)),
            );
    });
  }

  _sheetButtonView() {
    return GetBuilder<AppointmentCalendarController>(builder: (controller) {
      return MaterialButtonWidget(
        onPressed: () {
          if (type != null && controller.selectedIndex == null) {
            if (controller.bookingStartTime != null) {
              Get.back();
              Get.back();
            } else {
              Get.back();
              Get.back();
            }
          } else if (type != null && controller.selectedIndex != null) {
            if (controller.selectedIndex == null) {
              flashBar(message: strPleaseSelectSlot);
            } else {
              if (controller.bookingStartTime != null) {
                controller
                    .hitApiToRescheduleBookAppointment(controller.bookingId);
              } else {
                controller.hitApiToUpdateBookAppointment(controller.bookingId);
              }
            }
          } else {
            if (controller.selectedIndex == null) {
              flashBar(message: strPleaseSelectSlot);
            } else {
              controller.hitApiToBookAppointment();
            }
          }
        },
        buttonText: type != null && controller.selectedIndex == null
            ? strContinuewithsameslot
            : type != null && controller.selectedIndex != null
                ? strUpdate
                : strBookNow.toUpperCase(),
      ).paddingOnly(top: margin_20);
    });
  }
}
