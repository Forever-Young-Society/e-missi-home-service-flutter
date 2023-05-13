/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/rating_list_response_model.dart';
import 'package:e_missi_service_provider/export.dart';

class RatingController extends GetxController {
  TextEditingController? confirmTextController;
  TextEditingController? nameTextController;
  TextEditingController? identificationTextController;
  TextEditingController? mobileTextController;
  TextEditingController? addressTextController;
  TextEditingController? medicalConditionTextController;
  TextEditingController? dobTextController;
  TextEditingController? emailTextController;
  FocusNode? confirmFocusNode;
  int isActive = sortLatest;
  final Repository _repository = Get.find<Repository>();
  LoginResponseModel? loginResponseModel = LoginResponseModel();
  RatingListResponseModel ratingListResponseModel =
      new RatingListResponseModel();
  List<RatingDataModel> ratingList = [];
  var pageNum = 0;
  FocusNode? nameFocusNode;
  FocusNode? identificationFocusNode;
  FocusNode? mobileFocusNode;
  FocusNode? addressFocusNode;
  FocusNode? medicalConditionFocusNode;
  FocusNode? dobFocusNode;
  FocusNode? emailFocusNode;
  TextEditingController? passwordTextController;
  FocusNode? passwordFocusNode;
  bool isHide = false;
  bool isConfirmHide = false;
  Future? future;
  ScrollController scrollController = new ScrollController();
  bool loadMore = false;

  @override
  void onInit() {
    hitprofileDetailApi();
    future = hitRatingListApi(sortLatest, pageNum);
    initScroll();
    super.onInit();
  }

  initScroll() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        pageNum = pageNum + 1;
        if (ratingListResponseModel.mMeta!.pageCount != null &&
            ratingListResponseModel.mMeta!.pageCount >= pageNum) {
          loadMore = true;
          hitRatingListApi(isActive, pageNum);
        }
      }
      update();
    });
  }

  hitprofileDetailApi() async {
    await _repository.detailProfileApiCall().then((value) {
      loginResponseModel = value;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error!.toString());
    });
  }

  hitRatingListApi(type, page) async {
    await _repository.ratingListCall(type, page).then((value) {
      ratingListResponseModel = value;
      if (pageNum == 0) {
        ratingList.clear();
        ratingList = ratingListResponseModel.list!;
      } else {
        ratingList.addAll(ratingListResponseModel.list!);
      }
      loadMore = false;
      update();
    }).onError((error, stackTrace) {
      flashBar(message: error!.toString());
    });
  }
}
