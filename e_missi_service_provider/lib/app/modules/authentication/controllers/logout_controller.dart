/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class LogoutController extends GetxController {

  bool isAccountDeleted=false;
  @override
  void onInit() {
    if(Get.arguments!=null){
      isAccountDeleted=Get.arguments['isAccountDeleted'];
    }
    super.onInit();
  }



}
