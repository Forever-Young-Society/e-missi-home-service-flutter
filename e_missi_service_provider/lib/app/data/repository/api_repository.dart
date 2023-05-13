/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:e_missi_service_provider/app/data/repository/dio_client.dart';
import 'package:e_missi_service_provider/app/data/repository/endpoint.dart';
import 'package:e_missi_service_provider/app/data/repository/network_exceptions.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/category_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/language_response.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/location_list_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/login_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/my_slots_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/notifications_response.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/otp_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/skills_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/sub_category_response_model.dart';
import 'package:e_missi_service_provider/app/modules/authentication/models/response_models/sucess_response.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/booking_list_response_model.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/complete_booking_response.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/faq_reponse_model.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/rating_list_response_model.dart';
import 'package:e_missi_service_provider/app/modules/home/views/models/response_models/service_report_list_response.dart';
import 'package:e_missi_service_provider/model/error_response_model.dart';
import 'package:flutter/material.dart';

import '../../modules/home/views/models/response_models/booking_detail_response_mode.dart';

class Repository {
  static late DioClient? dioClient;
  String? deviceName, deviceType, deviceID,deviceVersion;

  Repository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }


  Future<ErrorMessageResponseModel> reportCrashLogApiCall({data}) async {
    try {
      final res = await
      Dio().post(crashBaseUrl + logCrashesExceptionsEndPoint,
          data: FormData.fromMap(data)
      );
      var response = res.data;
      return ErrorMessageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== signUp API Call  ==========================================================*/
  Future signUpApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(signUpEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== FAQ API Call  ==========================================================*/


  Future faqApiCall() async {
    try {
      final response = await dioClient!.get(faqEndPoint,
        queryParameters: {'type':1},
        skipAuth: false,);
      return FAQResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  /*===================================================================== login API Call  ==========================================================*/
  Future loginApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(loginEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*==================================================================notifications api============================================*/

  Future notificationListApiCall() async {
    try {
      final response = await dioClient!.get(
        notificationEndPoint,
        skipAuth: false,
        isLoading: false,
      );
      return NotificationResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*==================================================================notifications clear api============================================*/

  Future notificationListClearApiCall() async {
    try {
      final response = await dioClient!.get(
        notificationClearEndPoint,
        skipAuth: false,
      );
      return SuccessResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== verify otp user ============================================*/

  Future loginVerifyOtpApiCall(
      {required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(loginVerifyOtpEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== Add Slots Api ============================================*/

  Future addSlotsApiCall(
      {required Map<String, dynamic>? dataBody, startTim, endTim}) async {
    try {
      final response = await dioClient!.post(
        slotAddEndPoint,
        queryParameters: {startTime: startTim, endTime: endTim},
        data: FormData.fromMap(dataBody!),
        skipAuth: false,
      );
      return SuccessResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== create Account API Call  ==========================================================*/

  Future createAccountApiCall(
      {Map<String, dynamic>? dataBody, contactNo}) async {
    try {
      final response = await dioClient!.post(
        completeSignUpEndPoint,
        data: FormData.fromMap(dataBody!),
        queryParameters: {'contact_no': contactNo},
      );
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== update API Call  ==========================================================*/

  Future updateProfileApiCall(
      {Map<String, dynamic>? dataBody, contactNo}) async {
    try {
      final response = await dioClient!.post(updateProfileEndPoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== forgot API Call  ==========================================================*/
  Future forgotApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(forgotPasswordEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== resend otp user ============================================*/

  Future resendApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(resendEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== change password API Call  ==========================================================*/
  Future changePasswordApiCall(
      {Map<String, dynamic>? dataBody, contactNo}) async {
    try {
      final response = await dioClient!.post(changePasswordEndPoint,
          data: FormData.fromMap(dataBody!),
          queryParameters: {'contact_no': contactNo});
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== change password API Call  ==========================================================*/

  Future bookingReportPostApiCall(
      {Map<String, dynamic>? dataBody, bookingID}) async {
    try {
      final response = await dioClient!.post(bookingReportPostEndPoint,
          data: FormData.fromMap(dataBody!),
          skipAuth: false,
          queryParameters: {'booking_id': bookingID});
      return CompleteBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== register user ============================================*/

  Future checkApiCall() async {
    try {
      final response = await dioClient!.get(checkEndPoint, skipAuth: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== category list ============================================*/

  Future serviceCategoryApiCall({isLoading}) async {
    try {
      final response = await dioClient!
          .get(serviceCategoryEndPoint, isLoading: isLoading ?? true);
      return CategoryListResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== category list ============================================*/

  Future myCategoryApiCall({isLoading}) async {
    try {
      final response = await dioClient!.get(myCategoryEndPoint,
          isLoading: isLoading ?? true, skipAuth: false);
      return CategoryListResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== slots list ============================================*/

  Future slotListApiCall({categoryId, startTim, endTim}) async {
    try {
      final response = await dioClient!.get(slotsListEndPoint,
          skipAuth: false,
          queryParameters: {
            catId: categoryId,
            startTime: startTim,
            endTime: endTim
          });
      return MySlotsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== language list ============================================*/

  Future languageApiCall() async {
    try {
      final response = await dioClient!.get(languageEndPoint, isLoading: false);
      return LanguageResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== subCategory list ============================================*/

  Future serviceSubCategoryApiCall({catId}) async {
    try {
      final response = await dioClient!.get(skillListEndPoint,
          isLoading: false, queryParameters: {"cat_id": catId});
      return SkillSetResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== service report list ============================================*/

  Future serviceReportListApiCall() async {
    try {
      final response = await dioClient!
          .get(serviceReportListEndPoint, skipAuth: false, isLoading: false);
      return ServiceReportListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== logout user ============================================*/

  Future logoutApiCall() async {
    try {
      final response = await dioClient!.get(logoutEndPoint, skipAuth: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future detailProfileApiCall() async {
    try {
      final response = await dioClient!
          .get(userDetailEndPoint, skipAuth: false, isLoading: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future locationListApiCall() async {
    try {
      final response = await dioClient!.get(
        locationListEndPoint,
        isLoading: false,
        skipAuth: false,
      );
      return LocationListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== booking Detail Api ============================================*/

  Future bookingDetailApiCall(bookingID) async {
    try {
      final response = await dioClient!.get(bookingDetailEndPoint,
          queryParameters: {"id": bookingID},
          isLoading: false,
          skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return BookingDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== booking Detail Api ============================================*/

  Future bookingListApiCall(bookingID, page) async {
    try {
      final response = await dioClient!.get(bookingListEndPoint,
          queryParameters: {"state_id": bookingID, "page": page},
          isLoading: false,
          skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return BookingListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== start duty List Api ============================================*/

  Future startDutyListApiCall() async {
    try {
      final response = await dioClient!
          .get(startDutyListEndPoint, isLoading: false, skipAuth: false);
      return BookingListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*======================================================================Start booking Api ============================================*/

  Future startBookingApiCall(bookingID) async {
    try {
      final response = await dioClient!.get(startBookingEndPoint,
          queryParameters: {"booking_id": bookingID},
          isLoading: true,
          skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return BookingDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*======================================================================Complete booking Api ============================================*/

  Future completeBookingApiCall(bookingID) async {
    try {
      final response = await dioClient!.get(completeBookingEndPoint,
          queryParameters: {"booking_id": bookingID},
          isLoading: true,
          skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return CompleteBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Rating List Call  ==========================================================*/
  Future ratingListCall(type, page) async {
    try {
      final response = await dioClient!.get(ratingListEndPoint,
          queryParameters: {"type": type, "page": page},
          isLoading: false,
          skipAuth: false);
      return RatingListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== delete account Call  ==========================================================*/

  Future deleteAccountApiCall() async {
    try {
      final response =
          await dioClient!.get(deleteAccountEndPoint, skipAuth: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }
}
