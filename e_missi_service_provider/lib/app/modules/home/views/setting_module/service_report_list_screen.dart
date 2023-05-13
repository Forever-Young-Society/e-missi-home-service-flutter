/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class ServiceReportListScreen extends GetView<ServiceReportListController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceReportListController>(
      init: ServiceReportListController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appBarView2(title: strServicesReportList),
              Expanded(
                child: controller.serviceList?.length == 0 ||
                        controller.serviceList?.length == null
                    ? Center(
                        child: Text(strNoServiceReportAdded,
                            style:
                                TextStyle(fontSize: font_20, color: appColor)),
                      )
                    : CustomFutureBuilder(
                        widget: ListView.builder(
                          itemCount: controller.serviceList?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            var item = controller.serviceList?[index];
                            return card(item);
                          },
                        ),
                        future: controller.future,
                      ),
              )
            ],
          ).paddingSymmetric(horizontal: margin_15),
        );
      },
    );
  }

  card(ServiceReportDataModel? item) {
    return InkWell(
      onTap: () {
        if (item?.stateId == 1) {
          Get.toNamed(AppRoutes.serviceReportAddScreen,
              arguments: AppArguments.serviceReportAddScreenData(
                  appointmentData: item, isCompleted: true));
        }
      },
      child: Container(
        padding: EdgeInsets.all(margin_16),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius_18),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 3)
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AssetImageWidget(
              imageUrl: ic_servicecalander,
              imageHeight: height_60,
            ).paddingOnly(right: margin_10),
            details(item)
          ],
        ),
      ).marginSymmetric(vertical: margin_10, horizontal: margin_5),
    );
  }

  details(ServiceReportDataModel? item) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
                  textAlign: TextAlign.start,
                  maxLine: 10,
                  text: item?.serviceProvided?.toString() ?? "",
                  textStyle: textStyleHeading2().copyWith(color: Colors.black))
              .paddingOnly(bottom: margin_10),
          description(
              descriptionHeading: strOrderIdd,
              descriptionSubHeading: item?.id?.toString() ?? ""),
          description(
              descriptionHeading: strDateTime,
              descriptionSubHeading:
                  getDateString(item?.bookingDate?.toString() ?? "")),
          item?.stateId == 0 ? fillButton(item) : Container()
        ],
      ),
    );
  }

  fillButton(ServiceReportDataModel? item) {
    return InkWell(
      onTap: () async {
        var data = await Get.toNamed(AppRoutes.serviceReportAddScreen,
            arguments: AppArguments.serviceReportAddScreenData(
                appointmentData: item, isCompleted: false));
        if (data != null) {
          controller.serviceReportListApiCall();
          controller.update();
        }
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: margin_10, horizontal: margin_15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appColor,
          borderRadius: BorderRadius.circular(radius_5),
        ),
        child: TextView(
            text: strFillUpNow,
            textStyle: textStyleHeading2()
                .copyWith(color: Colors.white, fontSize: font_14)),
      ),
    );
  }

  description({descriptionHeading, descriptionSubHeading}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextView(
                text: descriptionHeading,
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        TextView(
                text: ': ',
                textStyle: textStyleBody2().copyWith(color: Colors.grey))
            .paddingOnly(bottom: margin_3),
        Flexible(
          child: TextView(
                  text: descriptionSubHeading,
                  textAlign: TextAlign.start,
                  maxLine: 3,
                  textStyle: textStyleBody2().copyWith(color: Colors.grey))
              .paddingOnly(bottom: margin_11),
        ),
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
}
