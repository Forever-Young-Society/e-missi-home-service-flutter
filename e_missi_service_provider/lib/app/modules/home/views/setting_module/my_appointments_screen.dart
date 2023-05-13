/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MyAppointmentsScreen extends GetView<MyAppointmentsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAppointmentsController>(
        init: MyAppointmentsController(),
        builder: (controller) {
          return CustomFutureBuilder(
            widget: _body(controller),
            future: controller.future,
          );
        });
  }

/*======================================================== _body ============================================*/

  Widget _body(controller) => Container(
        margin: EdgeInsets.only(top: margin_20, bottom: margin_8),
        child:
            controller.bookingList != null && controller.bookingList.length != 0
                ? ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: margin_20),
                    itemBuilder: (context, index) {
                      return MyAppointmentsCommonCardView(
                        ontap: () {
                          if (controller.bookingList[index].stateId ==
                              statePending) {
                            controller.hitApiToStartDutyTime(
                                controller.bookingList[index].id);
                          } else {
                            controller.hitApiToCompleteDutyTime(
                                controller.bookingList[index].id);
                          }
                        },
                        bookingList: controller.bookingList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height_10);
                    },
                    itemCount: controller.bookingList.length ?? 0)
                : Center(
                    child: Text(
                      "No Booking found",
                      style: textStyleTitle().copyWith(color: Colors.grey),
                    ),
                  ),
      );
}
