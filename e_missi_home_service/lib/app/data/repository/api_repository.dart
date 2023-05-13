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
import 'package:e_missi_home_service/app/core/values/route_arguments.dart';
import 'package:e_missi_home_service/app/data/repository/dio_client.dart';
import 'package:e_missi_home_service/app/data/repository/endpoint.dart';
import 'package:e_missi_home_service/app/data/repository/network_exceptions.dart';
import 'package:e_missi_home_service/app/modules/appointment_module/models/response_model/add_booking_response_model.dart';
import 'package:e_missi_home_service/app/modules/appointment_module/models/response_model/booking_detail_response_mode.dart';
import 'package:e_missi_home_service/app/modules/appointment_module/models/response_model/my_slots_response_model.dart';
import 'package:e_missi_home_service/app/modules/appointment_module/models/response_model/payment_history_response.dart';
import 'package:e_missi_home_service/app/modules/appointment_module/models/response_model/provider_availability_response.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/response_models/faq_reponse_model.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/response_models/login_response_model.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/response_models/notifications_response.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/response_models/static_pages_response_model.dart';
import 'package:e_missi_home_service/app/modules/authentication/models/response_models/sucess_response.dart';
import 'package:e_missi_home_service/app/modules/home/model/response_model/add_rating_response_model.dart';
import 'package:e_missi_home_service/app/modules/home/model/response_model/booking_list_response_model.dart';
import 'package:e_missi_home_service/app/modules/home/model/response_model/service_report_list_response.dart';
import 'package:e_missi_home_service/app/modules/nursing_service_module/model/response_model/location_list_response_model.dart';
import 'package:e_missi_home_service/app/modules/nursing_service_module/model/response_model/services_match_list_response_model.dart';
import 'package:e_missi_home_service/model/error_response_model.dart';
import 'package:flutter/material.dart';

import '../../modules/appointment_module/models/response_model/home_services_terms_response_model.dart';
import '../../modules/home/model/category_response_model.dart';
import '../../modules/home/model/dependent_detail_response_model.dart';
import '../../modules/home/model/dependent_list_response_model.dart';
import '../../modules/home/model/sub_category_response_model.dart';
import '../../modules/nursing_service_module/model/response_model/location_zip_code_response_model.dart';
import '../../modules/nursing_service_module/model/response_model/nurses_detail_response_model.dart';

class Repository {
  static late DioClient? dioClient;
  String? deviceName, deviceType, deviceID, deviceVersion;

  // static late CancelToken cancelToken;
  Repository() {
    var dio = Dio();
    //  cancelToken=CancelToken();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceName = "Android";
      deviceID = androidDeviceInfo.id;
      deviceType = "1";
      deviceVersion = androidDeviceInfo.version.release;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceType = "2";
      deviceVersion = iosDeviceInfo.systemVersion;
    }
  }

  /*===================================================================== report crash API Call  ==========================================================*/

  Future<ErrorMessageResponseModel> reportCrashLogApiCall({data}) async {
    try {
      final res = await Dio().post(crashBaseUrl + logCrashesExceptionsEndPoint,
          data: FormData.fromMap(data));
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

  /*===================================================================== login API Call  ==========================================================*/
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

  /*===================================================================== addDependentApiCall API Call  ==========================================================*/
  Future addDependentApiCall(
      {Map<String, dynamic>? dataBody, contactNo}) async {
    try {
      final response = await dioClient!.post(
        addDependentEndPoint,
        skipAuth: false,
        data: FormData.fromMap(dataBody!),
      );
      return DependentDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== matchesListApiCall API Call  ==========================================================*/
  Future matchesListApiCall(
      {Map<String, dynamic>? dataBody, contactNo, page}) async {
    try {
      final response = await dioClient!.post(matchesListEndPoint,
          skipAuth: false,
          data: FormData.fromMap(dataBody!),
          queryParameters: {"page": page});
      return ServicesMatchListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== addDependentApiCall API Call  ==========================================================*/
  Future removeDependentApiCall({id}) async {
    try {
      final response = await dioClient!.post(
        removeDependentEndPoint,
        skipAuth: false,
        queryParameters: {'id': id},
      );
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== addDependentApiCall API Call  ==========================================================*/
  Future servicesDtailsApiCall({id}) async {
    try {
      final response = await dioClient!.post(
        servicesDetailsEndPoint,
        skipAuth: false,
        queryParameters: {'id': id},
      );
      return NursesServicesDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== addDependentApiCall API Call  ==========================================================*/
  Future updateDependentApiCall({Map<String, dynamic>? dataBody, id}) async {
    try {
      final response = await dioClient!.post(
        EditDependentEndPoint,
        queryParameters: {'id': id},
        skipAuth: false,
        data: FormData.fromMap(dataBody!),
      );
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== verify otp user ============================================*/

  Future loginVerifyOtpApiCall({
    required Map<String, dynamic>? dataBody,
  }) async {
    try {
      final response = await dioClient!
          .post(loginVerifyOtpEndPoint, data: FormData.fromMap(dataBody!));
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future detailProfileApiCall() async {
    try {
      final response = await dioClient!.get(
        userDetailEndPoint,
        skipAuth: false,
      );
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future detailDependentProfileApiCall({id}) async {
    try {
      final response = await dioClient!.get(DependentDetailEndPoint,
          skipAuth: false, queryParameters: {'id': id});
      return DependentDetailResponseModel.fromJson(response);
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

  /*====================================================================== update user ============================================*/

  Future updateProfileApiCall({required Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(updateProfileEndPoint,
          data: FormData.fromMap(dataBody!), skipAuth: false);
      return LoginResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== provider slot ============================================*/

  Future providerSlotsApiCall(
      {required Map<String, dynamic>? dataBody, rescheduleTime}) async {
    try {
      final response = await dioClient!.post(getProviderSlotListEndPoint,
          queryParameters: {"reschedule_time": rescheduleTime ?? ""},
          data: FormData.fromMap(dataBody!),
          skipAuth: false,
          isLoading: false);
      return MySlotsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*==================================================================getProfileApiCall============================================*/

  Future dependentListApiCall({isLoading}) async {
    try {
      final response = await dioClient!.get(
        dependentListEndPoint,
        skipAuth: false,
        isLoading: isLoading,
      );
      return DependentListResponseModel.fromJson(response);
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

  /*==================================================================getProfileApiCall============================================*/

  Future providerAvailabilityApiCall(
      {isLoading, serviceI, providerI, date}) async {
    try {
      final response = await dioClient!.get(providerAvailabilityEndPoint,
          skipAuth: false,
          isLoading: isLoading,
          queryParameters: {
            serviceId: serviceI,
            providerId: providerI,
            dateId: date
          });
      return ProviderAvailabilityResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*==================================================================notification list api============================================*/

  Future notificationListApiCall() async {
    try {
      final response = await dioClient!
          .get(notificationEndPoint, skipAuth: false, isLoading: false);
      return NotificationResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*==================================================================notification list clear api============================================*/

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

  /*====================================================================== register user ============================================*/

  Future checkApiCall({isLoading}) async {
    try {
      final response = await dioClient!.get(checkEndPoint, skipAuth: false);
      return LoginResponseModel.fromJson(response);
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

  Future getPagesApiCall({typdId}) async {
    try {
      final response = await dioClient!.get(getPagesEndPoint,
          skipAuth: false,
          queryParameters: {'type_id': typdId, applicationTypeKey: typeUser});
      return StaticPagesResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future faqApiCall() async {
    try {
      final response = await dioClient!.get(
        faqEndPoint,
        queryParameters: {'type': 0},
        skipAuth: false,
      );
      return FAQResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future locationListApiCall({isLoading}) async {
    try {
      final response = await dioClient!
          .get(locationListEndPoint, skipAuth: false, isLoading: isLoading);
      return LocationListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future locationZipCodeApiCall({locationId}) async {
    try {
      final response = await dioClient!.get(locationZipCodeEndPoint,
          skipAuth: false, queryParameters: {'location_id': locationId});
      return LocationZipCodeResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getHomeServicesTermsApiCall({catId}) async {
    try {
      final response = await dioClient!.get(serviceTermEndPoint,
          skipAuth: false, queryParameters: {'cat_id': catId});
      return HomeServicesTermsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future serviceAcceptTermTermsApiCall({termId}) async {
    try {
      final response = await dioClient!.get(serviceAcceptTermEndPoint,
          skipAuth: false, queryParameters: {'term_id': termId});
      return HomeServicesTermsResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future serviceCategoryApiCall() async {
    try {
      final response =
          await dioClient!.get(serviceCategoryEndPoint, skipAuth: false);
      return CategoryListResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== subCategory list ============================================*/

  Future serviceSubCategoryApiCall({
    catId,
  }) async {
    try {
      final response = await dioClient!.get(serviceSubCategoryEndPoint,
          isLoading: false,
          queryParameters: {"cat_id": catId},
          skipAuth: false);
      return SubCategoryListResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== book appointment Api ============================================*/

  Future bookAppointmentApiCall(dataBody) async {
    try {
      final response = await dioClient!.post(bookSlotEndPoint,
          data: FormData.fromMap(dataBody!), isLoading: true, skipAuth: false);
      return AddBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== update Book appointment Api ============================================*/

  Future updateBookAppointmentApiCall(dataBody, bookingID) async {
    try {
      final response = await dioClient!.post(updateBookSlotEndPoint,
          data: FormData.fromMap(dataBody!),
          queryParameters: {"booking_id": bookingID},
          isLoading: true,
          skipAuth: false);
      return AddBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== reSchedule Book appointment Api ============================================*/

  Future rescheduleAppointmentApiCall(dataBody, bookingID) async {
    try {
      final response = await dioClient!.post(reScheduleBookingEndPoint,
          data: FormData.fromMap(dataBody!),
          queryParameters: {"booking_id": bookingID},
          isLoading: true,
          skipAuth: false);
      return AddBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== booking Payment Api ============================================*/

  Future bookingPaymentApiCall(dataBody, bookingID) async {
    try {
      final response = await dioClient!.post(bookingPaymentEndPoint,
          queryParameters: {"booking_id": bookingID},
          data: FormData.fromMap(dataBody!),
          isLoading: true,
          skipAuth: false);
      debugPrint(json.encode(response));
      return AddBookingResponseModel.fromJson(response);
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
          queryParameters: {"booking_type": bookingID, "page": page},
          isLoading: false,
          skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return BookingListResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== Payment History Api ============================================*/

  Future paymentHistoryApiCall(page) async {
    try {
      final response = await dioClient!.get(paymentHistoryEndPoint,
          queryParameters: {"page": page}, isLoading: false, skipAuth: false);
      debugPrint("response ${json.encode(response)}");
      return PaymentHistoryResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*====================================================================== cancel booking Api ============================================*/

  Future cancelBookingApiCall(dataBody, bookingID) async {
    try {
      final response = await dioClient!.post(cancelBookingEndPoint,
          queryParameters: {"booking_id": bookingID},
          data: FormData.fromMap(dataBody!),
          isLoading: true,
          skipAuth: false);
      return BookingDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  /*===================================================================== Rating API Call  ==========================================================*/
  Future ratingApiCall(
      {Map<String, dynamic>? dataBody, providerID, modelID}) async {
    try {
      final response = await dioClient!.post(addRatingEndPoint,
          data: FormData.fromMap(dataBody!),
          isLoading: true,
          skipAuth: false,
          queryParameters: {'provider_id': providerID, "model_id": modelID});
      return AddRatingResponseModel.fromJson(response);
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
