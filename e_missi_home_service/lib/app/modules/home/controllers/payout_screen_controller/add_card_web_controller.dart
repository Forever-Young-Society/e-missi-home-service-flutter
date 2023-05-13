/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'dart:io';

import 'package:e_missi_home_service/export.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CardWebViewController extends GetxController {
  List weekList = [];
  String? url;
  bool isLoading = true;
  var bookingId, token;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void onReady() {
    if (Get.arguments != null) {
      bookingId = Get.arguments['bookingID'];
      token = Get.arguments['token'];
      url =
          "${baseWebUrl}${webViewPaymentEndPoint}?booking_id=${bookingId}&key=${token}";
      update();
      print("final url ${url}");
    }
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
    super.onReady();
  }
}
