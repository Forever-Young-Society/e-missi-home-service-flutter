/*
 * <!--
 *   ~  @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *   ~  @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *   ~  All Rights Reserved.
 *   ~  Proprietary and confidential :  All information contained herein is, and remains
 *   ~  the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *   ~ Unauthorized copying of this file, via any medium is strictly prohibited.
 *   -->
 */

import '../../../export.dart';

class CustomFutureBuilder extends StatelessWidget {
  CustomFutureBuilder({this.future, this.widget});
  final Future? future;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, result) {
        log.e(result.connectionState);

        switch (result.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: SpinKitFadingCircle(
              color: appColor,
            ));
          case ConnectionState.active:
            return Center(
                child: SpinKitFadingCircle(
              color: appColor,
            ));

          case ConnectionState.done:
            return widget!;
            break;
          case ConnectionState.none:
            return Center(
                child: SpinKitFadingCircle(
              color: appColor,
            ));
          default:
            return Center(
                child: SpinKitFadingCircle(
              color: appColor,
            ));
        }
      },
    );
  }
}
