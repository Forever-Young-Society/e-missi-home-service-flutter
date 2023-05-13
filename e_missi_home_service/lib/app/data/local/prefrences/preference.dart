/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:convert';

import 'package:e_missi_home_service/app/modules/authentication/models/data_model/login_data_model.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/remember_me.dart';
import 'package:e_missi_home_service/main.dart';

class PreferenceManger {
  static const String isFirstLaunch = "isFirstLaunch";
  static const String authToken = "authToken";
  static const String loginResponseModel = "loginResponseModel";
  static const String staticResponseModel = "staticResponseModel";
  static const String rememberMe = "rememberMe";
  static const String isNotification = "isNotification";
  static const String email = "email";
  static const String password = "password";
  static const String rememberMeTeacher = "rememberMeTeacher";

  firstLaunch(bool? isFirstCheck) {
    localStorage.write(isFirstLaunch, isFirstCheck);
  }

  saveAuthToken(String? token) {
    localStorage.write(authToken, token);
  }

  getAuthToken() {
    return localStorage.read(authToken);
  }

  getStatusFirstLaunch() {
    return localStorage.read(isFirstLaunch);
  }

  saveRegisterData(LoginDataModel? model) async {
    localStorage.write(loginResponseModel, jsonEncode(model));
  }

  getSavedLoginData() async {
    Map<String, dynamic>? userMap;
    final userStr = await localStorage.read(loginResponseModel);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    if (userMap != null) {
      LoginDataModel user = LoginDataModel.fromJson(userMap);
      return user;
    }
    return null;
  }

  clearLoginData() {
    localStorage.remove(loginResponseModel);
    localStorage.remove(authToken);
  }

  static rememberMeWrite(RememberMeModel rememberModel) {
    return localStorage.write(rememberMe, jsonEncode(rememberModel));
  }

  static rememberMeRead() {
    Map<String, dynamic> userMap = Map();
    final String? userStr = localStorage.read(rememberMe);
    if (userStr != null) userMap = jsonDecode(userStr) as Map<String, dynamic>;
    return RememberMeModel.fromJson(userMap);
  }
}
