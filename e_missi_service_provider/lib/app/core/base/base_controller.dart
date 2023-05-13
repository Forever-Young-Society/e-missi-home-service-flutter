/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/app/core/base/page_state.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/api_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/app_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/json_format_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/network_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/not_found_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/service_unavailable_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/timeout_exception.dart';
import 'package:e_missi_service_provider/service/remote_service/network/exceptions/unauthorize_exception.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

abstract class BaseController extends GetxController {
  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  refreshPage(bool refresh) => _refreshController(refresh);

  //Controls page state
  final _pageSateController = PageState.DEFAULT.obs;

  PageState get pageState => _pageSateController.value;

  updatePageState(PageState state) => _pageSateController(state);

  resetPageState() => _pageSateController(PageState.DEFAULT);

  showLoading() => updatePageState(PageState.LOADING);

  hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  showErrorMessage({required String msg}) {
    _errorMessageController(msg);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  showSuccessMessage(String msg) => _successMessageController(msg);

  // ignore: long-parameter-list
  dynamic callDataService<T>(
    Future<T> future, {
    Function(Exception exception)? onError,
    Function(T response)? onSuccess,
    Function? onStart,
    Function? onComplete,
  }) async {
    Exception? _exception;

    onStart == null ? showLoading() : onStart();

    try {
      final T response = await future;

      if (onSuccess != null) onSuccess(response);

      onComplete == null ? hideLoading() : onComplete();

      return response;
    } on ServiceUnavailableException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on UnauthorizedException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on TimeoutException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on NetworkException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on JsonFormatException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on NotFoundException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } on ApiException catch (exception) {
      _exception = exception;
    } on AppException catch (exception) {
      _exception = exception;
      showErrorMessage(msg: exception.message);
    } catch (error) {
      _exception = AppException(message: "$error");
      Logger().e("Controller>>>>>> error $error");
    }

    if (onError != null) onError(_exception);

    onComplete == null ? hideLoading() : onComplete();
  }

  @override
  void onClose() {
    _messageController.close();
    _refreshController.close();
    _pageSateController.close();
    super.onClose();
  }
}
