import 'dart:convert';
import 'dart:io';

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
          'com.emissi.homeservice',
          'FYS',
          importance: Importance.max,
          groupKey: 'FYS',
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
        'FYS',
        event.data['message'],
        platformChannelSpecifics,
      );
    }
    print("data of notification ${event.data}");
  }

  onAppOpened() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print("data of notification ${event}");

      if (event != null) {
        onSelectNotification(event.data['data']);
      }
    });
  }

  Future onSelectNotification(Map<String, dynamic> data) async {
    switch (data['action']) {
      case "start-booking":
        {
          isRedirectSplash = true;
          Get.deleteAll(force: true);
          Get.toNamed(AppRoutes.appointmentDetailScreen,
              arguments: AppArguments.appointmentDetailData(
                  bookingId: jsonDecode(data['detail'])['model_id'].toString(),
                  isNotified: true,
                  rate: data['action'] == "complete-booking" ? true : false));
          break;
        }
      case "complete-booking":
        {
          isRedirectSplash = true;
          Get.deleteAll(force: true);
          Get.toNamed(AppRoutes.appointmentDetailScreen,
              arguments: AppArguments.appointmentDetailData(
                  bookingId: jsonDecode(data['detail'])['model_id'].toString(),
                  isNotified: true,
                  rate: data['action'] == "complete-booking" ? true : false));
          break;
        }
    }
  }
}
