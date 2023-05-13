/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:e_missi_service_provider/export.dart';


class MyAppointmentsController extends GetxController {
  RxInt selectedTransaction = 0.obs;
  final Repository _repository = Get.find<Repository>();
  BookingListResponseModel? bookingListResponseModel;
  List<BookingDetailDataModel> bookingList = [];
  var pageNum = 0;
  Future? future;
  ScrollController scrollController = ScrollController();
  CompleteBookingResponseModel? bookingDetailResponseModel;
  bool loadMore = false;

  void onReady() {
    future = hitApiToGetStartDutyList();
    initScroll();
    super.onReady();
  }

  initScroll() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pageNum = pageNum + 1;
        if (bookingListResponseModel?.mMeta!.pageCount != null &&
            bookingListResponseModel?.mMeta!.pageCount >= pageNum) {
          loadMore = true;
          hitApiToGetStartDutyList();
        }
      }
      update();
    });
  }

  hitApiToGetStartDutyList() async {
    await _repository.startDutyListApiCall().then((value) async {
      bookingListResponseModel = value;
      if (pageNum == 0) {
        bookingList.clear();
        bookingList = bookingListResponseModel!.list!;
      } else {
        bookingList.addAll(bookingListResponseModel!.list!);
      }
      loadMore = false;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  hitApiToStartDutyTime(bookingId) {
    _repository.startBookingApiCall(bookingId).then((value) {
      BookingDetailResponseModel bookingDetailResponseModel = value;
      int inde = bookingList.indexWhere(
          (element) => element.id == bookingDetailResponseModel.detail!.id);
      bookingList[inde].stateId = bookingDetailResponseModel.detail!.stateId;
      update();
      flashBar(message: bookingDetailResponseModel.message ?? "");
    }).onError((error, stackTrace) {
      flashBar(message: error!.toString());
    });
  }

  hitApiToCompleteDutyTime(bookingId) {
    _repository.completeBookingApiCall(bookingId).then((value) async {
      bookingDetailResponseModel = value;
      _routNext();
      flashBar(message: bookingDetailResponseModel?.message ?? "");
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error!.toString());
    });
  }

  _routNext() async {
    var data = await Get.toNamed(AppRoutes.serviceReportAddScreen,
        arguments: AppArguments.serviceReportAddScreenData(
            appointmentData: bookingDetailResponseModel?.detail,
            isCompleted: false));
    if (data != null) {
      hitApiToGetStartDutyList();
      update();
    }
  }
}
