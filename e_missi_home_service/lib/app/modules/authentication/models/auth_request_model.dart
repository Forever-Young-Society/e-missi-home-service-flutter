/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthRequestModel {
  /*================================================== Log-Crash Request Model==============================================*/

  static logCrashErrorReq({
    error,
    packageVersion,
    phoneModel,
    ip,
    stackTrace,
  }) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Log[error]'] = error;
    data['Log[link]'] = packageVersion;
    data['Log[referer_link]'] = phoneModel;
    data['Log[user_ip]'] = ip;
    data['Log[description]'] = stackTrace;
    return data;
  }

  /*==================================================Login Request Model==============================================*/
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

    debugPrint("login data ${data}");
    return data;
  }

  /*==================================================Login Request Model==============================================*/
  static createAccountRequestModel({
    required String? email,
    required String? name,
    required String? IdentityNumber,
    required String? password,
    required String? dob,
    required String? zipCode,
    required var files,
    required String? description,
    required String? address,
    required String? deviceType,
    required String deviceName,
    var gender,
    required String? deviceToken,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = name;
    data["User[email]"] = email;
    data["User[identity_number]"] = IdentityNumber;
    data["User[password]"] = password;
    data["User[date_of_birth]"] = dob;
    data["User[zipcode]"] = zipCode;
    data["File[key]"] = files;
    data["User[about_me]"] = description;
    data["User[gender]"] = gender;
    data["User[address]"] = address;
    data["LoginForm[device_type]"] = deviceType;
    data["LoginForm[device_name]"] = deviceName;
    data["LoginForm[device_token]"] = deviceToken;

    return data;
  }

  /*==================================================Login Request Model==============================================*/
  static addDependentAccountRequestModel({
    required String? email,
    required String? name,
    required String? IdentityNumber,
    required String? age,
    required String? dob,
    required String? mobile,
    var files,
    required String? zipCode,
    var profileFile,
    required String? aboutMe,
    required String? address,
    var gender,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = name;
    data["User[email]"] = email;
    data["User[identity_number]"] = IdentityNumber;
    data["User[age]"] = age;
    data["User[zipcode]"] = zipCode;
    data["User[profile_file]"] = profileFile;
    data["User[date_of_birth]"] = dob;
    data["User[contact_no]"] = mobile;
    data["File[key]"] = files;
    data["User[about_me]"] = aboutMe;
    data["User[gender]"] = gender;
    data["User[address]"] = address;
    return data;
  }

  /*==================================================Login Request Model==============================================*/
  static updateAccountRequestModel({
    required String? email,
    required String? name,
    required String? IdentityNumber,
    required String? dob,
    required var files,
    required var zipcode,
    var gender,
    required var profileFile,
    required String? description,
    required String? address,
    required String? oldPassword,
    required String? newPassword,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[full_name]"] = name;
    data["User[email]"] = email;
    data["User[identity_number]"] = IdentityNumber;
    data["User[date_of_birth]"] = dob;
    data["User[zipcode]"] = zipcode;
    data["File[key]"] = files;
    data["User[profile_file]"] = profileFile;
    data["User[about_me]"] = description;
    data["User[address]"] = address;
    data["User[gender]"] = gender;
    data["User[new_password]"] = newPassword;
    data["User[old_password]"] = oldPassword;
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

  /*================================================== provider slot Request Model==============================================*/

  static providerSlotsRequestModel({
    var providerId,
    var typeId,
    var startTime,
    var endTime,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["ProviderSlot[provider_id]"] = providerId;
    data["ProviderSlot[type_id]"] = typeId;
    data["ProviderSlot[start_time]"] = startTime;
    data["ProviderSlot[end_time]"] = endTime;
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

/*====================================================Forgot password Request Model====================================*/
  static forgotPasswordRequestModel({required String email}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[contact_no]"] = email;
    return data;
  }

  /*====================================================Forgot password Request Model====================================*/
  static changePasswordRequestModel({
    required String password,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["User[new_password]"] = password;
    return data;
  }

  /*====================================================servicesMatchListRequestModel====================================*/
  static servicesMatchListRequestModel({
    required String servicesId,
    required String zipCode,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SubCategory[service_ids]"] = servicesId;
    data["SubCategory[zipcode]"] = zipCode;

    print("data of match list ${data}");
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

  /*==================================================Book Slot Request Model==============================================*/

  static slotBookRequestModel({
    required var providerID,
    required var serviceID,
    required String? typeID,
    required var slotID,
    required String? startTime,
    required String? endTime,
    required var dependentID,
    required var workingZoneId,
    required var zipCode,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SlotBooking[provider_id]"] = providerID;
    data["SlotBooking[service_ids]"] = serviceID;
    data["SlotBooking[type_id]"] = typeID;
    data["SlotBooking[slot_id]"] = slotID;
    data["SlotBooking[start_time]"] = startTime;
    data["SlotBooking[end_time]"] = endTime;
    data["SlotBooking[dependant_id]"] = dependentID;
    data["SlotBooking[address]"] = workingZoneId;
    data["SlotBooking[zipcode]"] = zipCode;

    print("data of slot booking ${data}");

    return data;
  }

  /*==================================================Update Booking Request Model==============================================*/

  static updateSlotBookRequestModel({
    required var slotID,
    required String? startTime,
    required String? endTime,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};

    data["SlotBooking[slot_id]"] = slotID;
    data["SlotBooking[start_time]"] = startTime;
    data["SlotBooking[end_time]"] = endTime;

    return data;
  }

  /*==================================================Booking Payment Request Model==============================================*/

  static bookingPaymentRequestModel({
    required var transactionId,
    required var description,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SlotBooking[transaction_id]"] = transactionId;
    data["SlotBooking[description]"] = description;

    return data;
  }

  /*==================================================Cancel Booking Request Model==============================================*/

  static cancelBookingRequestModel({
    required var reason,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SlotBooking[cancel_reason]"] = reason;
    return data;
  }

  /*===================================================Update Request Model==============================================*/
  static addRatingRequestData({
    var rating,
    var comment,
    var model_id,
  }) {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Rating[rating]"] = rating;
    data["Rating[comment]"] = comment;
    data["Rating[model_id]"] = model_id;
    return data;
  }
}
