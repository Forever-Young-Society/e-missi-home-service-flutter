/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:collection';

import 'package:e_missi_home_service/export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WebScreen extends GetView<CardWebViewController> {
  final GlobalKey webViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardWebViewController>(
        init: CardWebViewController(),
        builder: (controller) {
          return _body();
        });
  }

/*======================================================== _body ============================================*/
  Widget _body() => Column(
        children: [
          appBarView2(title: strPayment),
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  controller.url != null
                      ? InAppWebView(
                          key: webViewKey,
                          initialUrlRequest:
                              URLRequest(url: Uri.parse(controller.url ?? "")),
                          // initialFile: "assets/index.html",
                          initialUserScripts:
                              UnmodifiableListView<UserScript>([]),
                          initialOptions: controller.options,
                          pullToRefreshController:
                              controller.pullToRefreshController,
                          onWebViewCreated: (controllers) {
                            controller.webViewController = controllers;
                          },
                          onLoadStart: (controller, url) {
                            debugPrint("onLoadUrl============= ${url}");
                          },
                          androidOnPermissionRequest:
                              (controller, origin, resources) async {
                            return PermissionRequestResponse(
                                resources: resources,
                                action: PermissionRequestResponseAction.GRANT);
                          },

                          onLoadStop: (controllers, string) async {
                            debugPrint("onLoadStop============= ${string}");
                            print("hellos page finish${string}");
                            controller.isLoading = false;
                            if (string.toString().contains("failed")) {
                              Timer(const Duration(milliseconds: 2000),
                                  () async {
                                Get.back();
                                flashBar(message: strPaymentFailed);
                              });
                            }
                            if (string.toString().contains("success")) {
                              Timer(const Duration(milliseconds: 2000),
                                  () async {
                                Get.toNamed(AppRoutes.mainScreen);
                                flashBar(message: strPaymentSuccess);
                              });
                            }
                            controller.update();
                          },
                          onLoadError: (controllers, url, code, message) {
                            debugPrint("onLoadError============= ${url}");
                            controller.pullToRefreshController?.endRefreshing();
                          },
                          onProgressChanged: (controller, progress) {},
                          onUpdateVisitedHistory:
                              (controller, url, androidIsReload) {
                            debugPrint(
                                "onUpdateVisitedHistory============= ${url}");
                          },
                          onConsoleMessage: (controller, consoleMessage) {
                            debugPrint(
                                "consoleMessage============= ${consoleMessage}");
                            print(consoleMessage);
                          },
                        )
                      : Container(),
                  controller.isLoading
                      ? Center(
                          child: SpinKitFadingCircle(
                            color: darkPurple,
                          ),
                        )
                      : Stack(),
                ],
              ),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: margin_10);
}
