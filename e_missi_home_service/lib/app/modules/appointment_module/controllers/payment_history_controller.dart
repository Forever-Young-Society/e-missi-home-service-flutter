/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:e_missi_home_service/export.dart';

class PaymentHistoryController extends GetxController {
  var pageNum = 0;
  Future ? future;
  ScrollController scrollController=new ScrollController();
  bool loadMore=false;
  final Repository _repository = Get.find<Repository>();
  PaymentHistoryResponse? paymentHistoryResponse;
  List<PaymentHistoryDataModel>? historyList;

  @override
  void onInit() {

    super.onInit();
  }
  @override
  void onReady() {
    future=hitApiToGetHistoryList(pageNum);
    initScroll();
    super.onReady();
  }
  initScroll()
  {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pageNum = pageNum + 1;
        if (paymentHistoryResponse?.mMeta!.pageCount != null &&
            paymentHistoryResponse?.mMeta!.pageCount >= pageNum) {
          loadMore = true;
          hitApiToGetHistoryList(pageNum);
        }
      }
      update();
    });
  }

  hitApiToGetHistoryList(page) async{
    await  _repository.paymentHistoryApiCall(page).then((value) async {
      paymentHistoryResponse = value;
      if(pageNum==0)
      {
        historyList?.clear();
        historyList=paymentHistoryResponse!.list!;
      }else{
        historyList?.addAll(paymentHistoryResponse!.list!);
      }
      loadMore=false;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

}
