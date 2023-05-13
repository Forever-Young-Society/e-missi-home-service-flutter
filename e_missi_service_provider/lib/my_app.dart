/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  All Rights Reserved.
 *  Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:e_missi_service_provider/export.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (context, widget) => FirebasePhoneAuthProvider(
          child: GetMaterialApp(
            theme: ThemeConfig.lightTheme,
            initialRoute: AppPages.INITIAL,
            initialBinding: InitialBinding(),
            title: strAppName,
            getPages: AppPages.routes,
            scaffoldMessengerKey: scaffoldMessengerState,
            navigatorKey: navState,
            debugShowCheckedModeBanner: false,
            enableLog: true,
            logWriterCallback: LoggerX.write,
            builder: EasyLoading.init(),
            defaultTransition: Transition.cupertino,
          ),
        )
      ),
    );
  }
}
