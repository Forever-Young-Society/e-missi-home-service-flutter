/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

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
            tabs(),
            SizedBox(height: height_20),
            Expanded(
                child: CustomFutureBuilder(
              future: controller.future,
              widget: controller.bookingList.length == 0
                  ? _listEmptyWidget()
                  : _bookingList(),
            ))
          ],
        ));
      },
    );
  }

  _listEmptyWidget() {
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
      ],
    );
  }

  _bookingList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.bookingList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.appointmentDetailScreen, arguments: {
                    'bookingId': controller.bookingList[index].id
                  });
                },
                child: CommonCardView(
                  bookingDetailDataModel: controller.bookingList[index],
                  onPressed: () {
                    Get.toNamed(AppRoutes.appointmentDetailScreen, arguments: {
                      'bookingId': controller.bookingList[index].id
                    });
                  },
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

  /*============================================_bodyWidget==========================================*/

  Widget tabs() {
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
                  appointmentUpcoming, controller.pageNum);
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
                  appointmentHistory, controller.pageNum);

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
