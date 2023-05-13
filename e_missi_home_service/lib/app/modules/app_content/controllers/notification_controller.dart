/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import '../../../../export.dart';

class NotificationController extends GetxController {
  final Repository _repository = Get.find<Repository>();
  NotificationResponseModel? notificationResponseModel;
  List<NotificationDataModel>? notificationList;

  @override
  void onInit() {
    super.onInit();
  }

  Future? future;
  ScrollController scrollController = new ScrollController();
  bool loadMore = false;
  var pageNum = 0;

  @override
  void onReady() {
    future = hitNotificationAPI();
    initScroll();

    super.onReady();
  }

  initScroll() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pageNum = pageNum + 1;
        if (notificationResponseModel?.mMeta!.pageCount != null &&
            notificationResponseModel?.mMeta!.pageCount >= pageNum) {
          loadMore = true;
          hitNotificationAPI();
        }
      }
      update();
    });
  }

  hitNotificationAPI() async {
    await _repository.notificationListApiCall().then((value) async {
      notificationResponseModel = value;
      if (pageNum == 0) {
        notificationList?.clear();
        notificationList = notificationResponseModel!.list!;
      } else {
        notificationList?.addAll(notificationResponseModel!.list!);
      }
      loadMore = false;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  SuccessResponse? successResponse;

  hitNotificationClearAPI() async {
    await _repository.notificationListClearApiCall().then((value) async {
      if (value != null) {
        successResponse = value;
        flashBar(message: successResponse?.message?.toString() ?? "");
        hitNotificationAPI();
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }
}
