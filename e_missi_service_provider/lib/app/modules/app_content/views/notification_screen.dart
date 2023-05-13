/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class NotificationScreen extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        return CustomFutureBuilder(
          widget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    _notificationsList(controller),
                    controller.notificationList?.length == 0 ||
                            controller.notificationList?.length == null
                        ? Container()
                        : Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: InkWell(
                              onTap: () {
                                controller.hitNotificationClearAPI();
                              },
                              child: TextView(
                                      text: strClearAll,
                                      textStyle: textStyleBody2().copyWith(
                                          color: Colors.grey,
                                          fontSize: font_18))
                                  .paddingOnly(
                                      bottom: margin_10, right: margin_15),
                            ))
                  ],
                ),
              ),
            ],
          ),
          future: controller.future,
        );
      },
    );
  }

  _notificationsList(NotificationController controller) {
    return controller.notificationList?.length == 0 ||
            controller.notificationList?.length == null
        ? Center(
            child: TextView(
              text: strNoNotificationFound,
              textStyle: textStyleBody1(),
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(
                vertical: margin_10, horizontal: margin_15),
            itemCount: controller.notificationList?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (controller.notificationList?[index].typeId == 0) {
                    Get.find<MainController>().selectedIndex = 2;
                    Get.find<MainController>().update();
                  } else if (controller.notificationList?[index].typeId == 1) {
                    Get.toNamed(AppRoutes.appointmentDetailScreen, arguments: {
                      'bookingId': controller.notificationList?[index].modelId
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(margin_15),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(radius_15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 4,
                          spreadRadius: 3)
                    ],
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AssetImageWidget(
                          imageUrl: ic_card,
                          imageHeight: height_50,
                          imageFitType: BoxFit.fill,
                        ).paddingOnly(right: margin_10),
                        Expanded(
                            child: TextView(
                                maxLine: 3,
                                textAlign: TextAlign.start,
                                text: controller.notificationList?[index].title
                                        ?.toString() ??
                                    "",
                                textStyle: textStyleBody2()
                                    .copyWith(color: Colors.black)))
                      ]),
                ).paddingSymmetric(vertical: margin_10),
              );
            },
          );
  }
}
