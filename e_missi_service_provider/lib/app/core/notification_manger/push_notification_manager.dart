import 'dart:io';

import 'package:e_missi_service_provider/app/modules/home/controllers/setting_module_controllers/my_appointments_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../export.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}
bool isRedirectSplash = false;

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
      PushNotificationsManager._();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;
  var platform;

  Future init() async {
    if (!_initialized) {
      _firebaseMessaging.requestPermission(alert: true, sound: true);
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);

      _firebaseMessaging
          .getToken()
          .then((value) => debugPrint("Firebase Messaging token $value"));
      _initialized = true;
      getIntialMessage();
      onMesage();
      onAppOpened();
      backGroundMessage();
    }
  }

  backGroundMessage() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  getIntialMessage() {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        onSelectNotification(message.data);
      }
    });
  }

  onMesage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data['action'] == "response") {
        if (Get.currentRoute == AppRoutes.mainScreen) {
          var controller = Get.put(MainController());
          if (controller.selectedIndex == 3) {
            Get.find<MyAppointmentsController>().hitApiToGetStartDutyList();
            Get.find<MyAppointmentsController>().update();
          }
          controller.update();
        }
      }
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: true);
      var androids = AndroidInitializationSettings('drawable/ic_notifications');
      var ios = new IOSInitializationSettings(
        defaultPresentSound: true,
        defaultPresentAlert: true,
      );
      var platform = new InitializationSettings(android: androids, iOS: ios);
      flutterLocalNotificationsPlugin.initialize(platform,
          onSelectNotification: (String? data) async {
        if (message != null) {
          onSelectNotification(message.data);
        }
      });
      if (Platform.isAndroid) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'com.jom_fys',
          'JOM FYS',
          importance: Importance.max,
          groupKey: 'JOM FYS',
          setAsGroupSummary: true,
          groupAlertBehavior: GroupAlertBehavior.all,
          playSound: true,
          channelShowBadge: true,
          visibility: NotificationVisibility.public,
          enableVibration: true,
        );
        var iOSPlatformChannelSpecifics = IOSNotificationDetails(
            presentSound: true, presentBadge: true, presentAlert: true);
        var platformChannelSpecifics = NotificationDetails(
            android: androidPlatformChannelSpecifics,
            iOS: iOSPlatformChannelSpecifics);
        showNotification(message, platformChannelSpecifics);
      }
    });
  }

  showNotification(
      RemoteMessage event, NotificationDetails platformChannelSpecifics) async {
    if (event != null) {
      await flutterLocalNotificationsPlugin.show(
        1,
        'JOM FYS',
        event.data['message'],
        platformChannelSpecifics,
      );
    }
  }

  onAppOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      onSelectNotification(event.data);
    });
  }

  Future onSelectNotification(Map<String, dynamic> data) async {
    switch (data['action']) {
      case "response":
        {
          isRedirectSplash = true;
          if (Get.currentRoute == AppRoutes.mainScreen) {
            var controller = Get.put(MainController());
            controller.selectedIndex = 3;
            controller.update();
          } else {
            Get.deleteAll(force: true);
            Get.offNamed(AppRoutes.mainScreen, arguments: {'selectedIndex': 3});
          }
          break;
        }
      case "reject-document":
        {
          isRedirectSplash = true;
          if (Get.currentRoute == AppRoutes.mainScreen) {
            var controller = Get.put(MainController());
            controller.selectedIndex = 2;
            controller.update();
          } else {
            Get.deleteAll(force: true);
            Get.offNamed(AppRoutes.mainScreen, arguments: {'selectedIndex': 2});
          }

          break;
        }
      case "reschedule-booking":
        {
          isRedirectSplash = true;
          if (Get.currentRoute == AppRoutes.mainScreen) {
            var controller = Get.put(MainController());
            controller.selectedIndex = 3;
            controller.update();
          } else {
            Get.deleteAll(force: true);
            Get.offNamed(AppRoutes.mainScreen, arguments: {'selectedIndex': 3});
          }
          break;
        }
    }
  }
}
