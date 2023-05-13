/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_missi_service_provider/app/modules/authentication/widget/common_widgets.dart';
import 'package:e_missi_service_provider/export.dart';
import 'package:e_missi_service_provider/model/error_response_model.dart';

class NetworkExceptions {
  static String messageData = "";

  static getDioException(error) {
    reportCrash(error.toString());
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return messageData = strRequestCancelled;
            case DioErrorType.connectTimeout:
              return messageData = strConnectionTimeOut;
            case DioErrorType.other:
              List<String> dateParts = error.message.split(":");
              List<String> message = dateParts[2].split(",");

              if (message[0].trim() == strConnectionRefused) {
                return messageData = strServerUnderMaintance;
              } else if (message[0].trim() == strNetworkUnReachable) {
                return messageData = strNetworkUnReachable;
              } else if (dateParts[1].trim() == strFalidToHostLookup) {
                return messageData = strNoInternetConnection;
              } else {
                return messageData = dateParts[1];
              }
            case DioErrorType.receiveTimeout:
              return messageData = strTimeOut;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case 400:
                  Map<String, dynamic> data = error.response?.data;

                  if (data.values.elementAt(0).runtimeType == String) {
                    return messageData = data.values.elementAt(0);
                  } else {
                    Map<String, dynamic> datas = data.values.elementAt(0);
                    if (data.values.elementAt(0) == null) {
                      var dataValue = ErrorMessageResponseModel.fromJson(
                              error.response?.data)
                          .message;
                      return dataValue == null
                          ? messageData = strUnauthorizeRequest
                          : messageData = dataValue;
                    } else {
                      return messageData = datas.values.first[0];
                    }
                  }
                case 401:
                  Get.find<PreferenceManger>().clearLoginData();
                  Get.offNamed(AppRoutes.logIn);
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 403:
                  Get.find<PreferenceManger>().clearLoginData();
                  Get.offNamed(AppRoutes.logIn);
                  try {
                    return messageData = error.response?.data['message'] ??
                        'Unauthorised Exception';
                  } catch (err) {
                    return messageData = 'Unauthorised Exception';
                  }
                case 404:
                  return messageData = strNotFound;
                case 408:
                  return messageData = strRequestTimeOut;
                case 500:
                  return messageData = strInternalServerError;
                case 503:
                  return messageData = strServiceUnavailable;
                default:
                  return messageData = strSomethingWorg;
              }
            case DioErrorType.sendTimeout:
              return messageData = strTimeOut;
          }
        } else if (error is SocketException) {
          return messageData = strSocketExceptions;
        } else {
          return messageData = strUnExceptedExption;
        }
      } on FormatException catch (_) {
        return messageData = strFormetException;
      } catch (_) {
        return messageData = strUnExceptedExption;
      }
    } else {
      return error.toString().contains(strNotSubType)
          ? messageData = strUnableToProcessData
          : messageData = strUnExceptedExption;
    }
  }
}
