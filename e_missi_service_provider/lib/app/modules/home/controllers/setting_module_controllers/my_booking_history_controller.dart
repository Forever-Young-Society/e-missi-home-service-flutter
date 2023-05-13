/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';


class MyBookingHistoryController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  BookingListResponseModel? bookingListResponseModel;
  List<BookingDetailDataModel> bookingList = [];
  var pageNum = 0;
  Future? future;
  ScrollController scrollController = new ScrollController();
  bool loadMore = false;

  @override
  void onReady() {
    future = hitApiToGetBookingList(appointmentHistory, pageNum);
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
          hitApiToGetBookingList(appointmentHistory, pageNum);
        }
      }
      update();
    });
  }

  hitApiToGetBookingList(stateID, page) async {
    await _repository.bookingListApiCall(stateID, page).then((value) async {
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
}
