/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class ServiceReportListController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  ServiceReportListResponseModel? serviceReportListResponseModel;
  List<ServiceReportDataModel>? serviceList;
  var pageNum = 0;
  Future? future;
  ScrollController? scrollController;
  bool loadMore = false;

  @override
  void onReady() {
    scrollController = ScrollController();
    future = serviceReportListApiCall();
    initScroll();
    super.onReady();
  }

  initScroll() {
    scrollController?.addListener(() {
      if (scrollController?.position.maxScrollExtent ==
          scrollController?.offset) {
        pageNum = pageNum + 1;
        if (serviceReportListResponseModel?.mMeta!.pageCount != null &&
            serviceReportListResponseModel?.mMeta!.pageCount >= pageNum) {
          loadMore = true;
          serviceReportListApiCall();
        }
      }
      update();
    });
  }

  serviceReportListApiCall() async {
    await _repository.serviceReportListApiCall().then((value) async {
      serviceReportListResponseModel = value;
      if (pageNum == 0) {
        serviceList?.clear();
        serviceList = serviceReportListResponseModel!.list!;
      } else {
        serviceList?.addAll(serviceReportListResponseModel!.list!);
      }
      loadMore = false;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}
