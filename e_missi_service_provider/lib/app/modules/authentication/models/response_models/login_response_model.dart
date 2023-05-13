/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class LoginResponseModel {
  String? accessToken;
  String? message;
  LoginDataModel? detail;
  String? copyrighths;

  LoginResponseModel({this.accessToken, this.detail, this.copyrighths});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access-token'];
    message = json['message'];
    detail =
        json['detail'] != null ? LoginDataModel.fromJson(json['detail']) : null;
    copyrighths = json['copyrighths'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access-token'] = accessToken;
    data['message'] = message;
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    data['copyrighths'] = copyrighths;
    return data;
  }
}
