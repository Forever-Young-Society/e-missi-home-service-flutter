/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class RatingController extends BaseController {
  BookingDetailDataModel? bookingDetailDataModel;
  final Repository _repository = Get.find<Repository>();
  var rate = 1.0;
  TextEditingController commentController = new TextEditingController();
  @override
  void onInit() {
    if (Get.arguments != null) {
      bookingDetailDataModel = Get.arguments['detail'];
    }
    super.onInit();
  }

  hitApiToGiveRate() {
    var data = AuthRequestModel.addRatingRequestData(
        rating: rate, comment: commentController.text.trim());
    _repository
        .ratingApiCall(
            dataBody: data,
            providerID: bookingDetailDataModel?.providerDetail?.id,
            modelID: bookingDetailDataModel?.id)
        .then((value) {
      AddRatingResponseModel addRatingResponseModel = value;
      bookingDetailDataModel?.providerDetail = addRatingResponseModel.detail;
      Get.back(result: true);
      flashBar(message: addRatingResponseModel.message ?? "");
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error!.toString());
    });
  }

  updateRate(rating) {
    rate = rating;
    update();
  }
}
