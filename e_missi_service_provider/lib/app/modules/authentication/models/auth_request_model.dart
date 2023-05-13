/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthRequestModel {

  /*================================================== Log-Crash Request Model==============================================*/

  static logCrashErrorReq({error, packageVersion, phoneModel, ip, stackTrace, }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }



  /*================================================== Registration Request Model==============================================*/
  static signUpRequestModel({
    required String? contact,
    required String? deviceType,
    required String deviceName,
    required int? roleId,
    required String? deviceToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[contact_no]"] = contact;
    data["User[role_id]"] = roleId;
    data["User[device_type]"] = deviceType;
    data["User[device_name]"] = deviceName;
    data["User[device_token]"] = deviceToken;
    return data;
  }

  /*==================================================Login Request Model==============================================*/
  static loginRequestModel({
    required String? password,
    required String? contact,
    required String? deviceType,
    required int? roleId,
    required String deviceName,
    required String? deviceToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["LoginForm[password]"] = password;
    data["LoginForm[username]"] = contact;
    data["LoginForm[role_id]"] = roleId;
    data["LoginForm[device_type]"] = deviceType;
    data["LoginForm[device_name]"] = deviceName;
    data["LoginForm[device_token]"] = deviceToken;
    return data;
  }

  /*==================================================Verify Otp Request Model==============================================*/

  static loginVerifyOtpRequestModel({
    required String? contactNo,
    String? mobileOtp,
    var otpVerified,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[contact_no]"] = contactNo;
    data["User[otp]"] = mobileOtp;
    data["User[otp_verified]"] = otpVerified;


    return data;
  }


  /*================================================== add slot Request Model==============================================*/

  static addSlotRequestModel({
    required var categoryId,
    var slotData,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ProviderSlot[type_id]"] = categoryId;
    data["ProviderSlot[slot]"] = jsonEncode(slotData);

    debugPrint("data of Add Slots ${data}");
    return data;
  }

  /*==================================================Verify Otp Request Model==============================================*/

  static resendOtpRequestModel({
    required String? contactNo,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[contact_no]"] = contactNo;
    return data;
  }

  /*==================================================== Change password Request Model====================================*/
  static changePasswordRequestModel({
    required String password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[new_password]"] = password;
    return data;
  }

  /*==================================================== Add service reporrt Request Model====================================*/
  static addServiceReportRequestModel({
    required String description,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Report[description]"] = description;
    return data;
  }

/*====================================================Forgot password Request Model====================================*/
  static forgotPasswordRequestModel({required String email}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[contact_no]"] = email;
    return data;
  }

  /*==================================================Verify Otp Request Model==============================================*/
  static verifyOtpRequestModel({
    required String? email,
    required String? otp,
    required String? deviceType,
    required String deviceName,
    required String? deviceToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[email]"] = email;
    data["User[otp]"] = otp;
    data["AccessToken[device_type]"] = deviceType;
    data["AccessToken[device_name]"] = deviceName;
    data["AccessToken[device_token]"] = deviceToken;
    return data;
  }

  static socialLoginRequestModel({
    required String fullName,
    required String username,
    required String email,
    required String mobielNumber,
    required String deviceType,
    required String deviceName,
    required String deviceToken,
    required String socialId,
    required String socialType,
    required String profileImage,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["full_name"] = fullName;
    data["username"] = username;
    data["email"] = email;
    data["mobile_no"] = mobielNumber;
    data["device_type"] = deviceType;
    data["device_name"] = deviceName;
    data["device_token"] = deviceToken;
    data["social_id"] = socialId;
    data["social_type"] = socialType;
    data["profile_pic"] = profileImage;
    return data;
  }

  /*===================================================Update Request Model==============================================*/
  static updateProfileRequestData({
    required String? fullName,
    required String? email,
    required String? mobileNo,
    MultipartFile? profileImage,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = fullName;
    data["User[email]"] = email;
    data["User[contact_no]"] = mobileNo;
    data["User[profile_file]"] = profileImage;
    return data;
  }

  /*=================================================== complete profile Request Model==============================================*/
  static createAccountRequestData({
    String? fullName,
    String? email,
    String? password,
    String? identityNumber,
    String? dob,
    String? zipcode,
    String? aboutMe,
    String? experience,
    var gender,
    String? workType,
    var workZone,
    String? address,
    String? qualification,
    String? serviceLang,
    String? skill,
    String? deviceToken,
    String? deviceName,
    String? deviceType,
    var certificateImage,
    var profileImage,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = fullName;
    data["User[email]"] = email;
    data["User[password]"] = password;
    data["User[identity_number]"] = identityNumber;
    data["User[date_of_birth]"] = dob;
    data["User[zipcode]"] = zipcode;
    data["User[about_me]"] = aboutMe;
    data["User[experience]"] = experience;
    data["User[gender]"] = gender;
    data["User[work_zone]"] = workZone;
    data["User[work_type]"] = workType;
    data["User[address]"] = address;
    data["User[qualification]"] = qualification;
    data["User[service_language]"] = serviceLang;
    data["User[skill]"] = skill;
    data["LoginForm[device_token]"] = deviceToken;
    data["LoginForm[device_name]"] = deviceName;
    data["LoginForm[device_type]"] = deviceType;
    data["File[key][]"] = certificateImage;
    data["User[profile_file]"] = profileImage;

    debugPrint("data of create account ${data}");
    return data;
  }

  /*=================================================== complete profile Request Model==============================================*/
  static updateAccountRequestData({
    String? fullName,
    String? email,
    String? password,
    String? identityNumber,
    String? dob,
    String? zipcode,
    String? aboutMe,
    String? experience,
    var gender,
    var workZone,
    String? workType,
    String? address,
    String? qualification,
    String? serviceLang,
    String? skill,
    String? deviceToken,
    String? deviceName,
    String? deviceType,
    var certificateImage,
    var profileImage,
    var newPassword,
    var oldPassword,
    var fileId,
    var fileNewUpload,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = fullName;
    data["User[email]"] = email;
    data["User[identity_number]"] = identityNumber;
    data["User[date_of_birth]"] = dob;
    data["User[zipcode]"] = zipcode;
    if (workZone != null) {
      data["User[work_zone]"] = workZone;
    }
    data["User[about_me]"] = aboutMe;
    data["User[experience]"] = experience;
    data["User[gender]"] = gender;
    data["User[work_type]"] = workType;
    data["User[address]"] = address;
    data["User[qualification]"] = qualification;
    data["User[service_language]"] = serviceLang;
    data["User[skill]"] = skill;
    data["LoginForm[device_token]"] = deviceToken;
    data["LoginForm[device_name]"] = deviceName;
    data["LoginForm[device_type]"] = deviceType;
    data["User[file_id]"] = fileId;
    data["File[name][]"] = fileNewUpload;
    if (certificateImage != null) {
      data["File[key][]"] = certificateImage;
    }
    if (profileImage != null) {
      data["User[profile_file]"] = profileImage;
    }
    if (newPassword != null) {
      data["User[new_password]"] = newPassword;
    }
    if (oldPassword != null) {
      data["User[old_password]"] = oldPassword;
    }
    debugPrint("data of create account ${data}");
    return data;
  }

}
