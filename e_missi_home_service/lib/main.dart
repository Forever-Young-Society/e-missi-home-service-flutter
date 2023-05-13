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
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'app/core/widget/custom_loader.dart';

CustomLoader customLoader = CustomLoader();
GetStorage localStorage = GetStorage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Firebase.initializeApp();
  PlatformDispatcher.instance.onError = (error, stack) {
    reportCrash(error.toString()+'\n'+stack.toString());
    return true;
  };

  FlutterError.onError = (details) async {
    if (details.stack != null) {
      await FirebaseCrashlytics.instance.recordFlutterError(details);
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      reportCrash(details.exception.toString()+'\n'+details.stack.toString());
    } else {
      FlutterError.presentError(details);
    }
  };
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  initApp();
  orientation();

}

initApp() async {
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stack) {
    debugPrint("error Received $error");
  });
}


init() async {
  await GetStorage.init();
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Platform.isIOS?Brightness.light:Brightness.dark,
    statusBarIconBrightness:  Platform.isIOS?Brightness.light:Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
