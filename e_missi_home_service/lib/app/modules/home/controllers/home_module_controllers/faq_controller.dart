/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_home_service/export.dart';

class FAQController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository _repository = Get.find<Repository>();
  FAQResponseModel faqResponseModel = FAQResponseModel();
  List<FAQDataModel>? faqList;
  AnimationController? animationController;
  var type;
  late Animation<double> animation;
  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      upperBound: 0.5,
    );
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.decelerate);
    super.onInit();
  }

  @override
  void onReady() {
    getFAQApiCall();
    super.onReady();
  }

  getFAQApiCall() {
    _repository.faqApiCall().then((value) async {
      if (value != null) {
        faqResponseModel = value;
        faqList = faqResponseModel.list ?? [];
        update();
      }
    }).onError((error, stackTrace) {
      flashBar(message: error.toString());
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
