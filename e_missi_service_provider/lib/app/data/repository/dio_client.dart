/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

// Package imports:

// Project imports:

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_missi_service_provider/app/logger/log_interceptor.dart'
    as LogInterceptor;
import 'package:e_missi_service_provider/export.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;
final PreferenceManger _preferenceManger = Get.find<PreferenceManger>();

setContentType() {
  return "application/json";
}

class DioClient {
  String baseUrl;

  static late Dio _dio;

  final List<Interceptor>? interceptors;

  DioClient(
    this.baseUrl,
    Dio dio, {
    this.interceptors,
  }) {
    _dio = dio;
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.contentType = setContentType()
      ..options.headers = {
        'Content-Type': setContentType(),
      };

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor.LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress,
      bool? isLoading = true,
      bool? skipAuth}) async {
    try {
      if (skipAuth == false) {
        var token = _preferenceManger.getAuthToken();
        debugPrint("token $token");
        if (token != null) {
          options = Options(headers: {"Authorization": "Bearer $token"});
        }
      }
      if (isLoading == true) {
        customLoader.show(Get.context);
      }

      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      if (isLoading == true) {
        customLoader.hide();
      }
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (isLoading == true) {
        customLoader.hide();
      }
      rethrow;
    }
  }

  Future<dynamic> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      bool? isLoading = true,
      bool? skipAuth}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    try {
      if (skipAuth == false) {
        var token = _preferenceManger.getAuthToken();
        debugPrint("authorization============ $token");
        if (token != null) {
          options ??= Options(headers: {"Authorization": "Bearer $token"});
        }
      }
      if (isLoading == true) {
        customLoader.show(Get.context);
      }
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (isLoading == true) {
        customLoader.hide();
      }
      return response.data;
    } on FormatException catch (_) {
      if (isLoading == true) {
        customLoader.hide();
      }
      throw const FormatException("Unable to process the data");
    } catch (e) {
      if (isLoading == true) {
        customLoader.hide();
      }
      rethrow;
    }
  }

  static Future<dynamic> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
