import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/model/common/user_model.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/splash_view.dart';
import 'package:zimbo/views/other/add_score_view.dart';
import 'package:zimbo/views/other/menu_view.dart';
import 'package:zimbo/views/other/qr_scanner_view.dart';

import '../../model/common/receive_notification.dart';

class MainViewModel extends BaseViewModel {
  int selectedIndex = 2;

  String? selectedNotificationPayload;
  String? token;
  UserModel? userModel;
  static bool isInitialized = false;

  initialize(BuildContext context, int? selectedVal) async {
    if (selectedVal != null) {
      selectedIndex = selectedVal;
    }

    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request().then((value) => {});
    }

    if (Platform.isAndroid) {
      setupNotificationAndroid(context);
    } else if (Platform.isIOS) {
      setupNotificationIOS(context);
    }

    token = await sharedService.getToken();

    networkService.doGetProfile(token!).then((value) => {
          if (value != null)
            {
              userModel = value,
              sharedService.saveUser(userModel),
              notifyListeners(),
            }
        });

    handleIncomingLinks(context);
    if (!isInitialized) {
      await handleInitialUri(context);
      isInitialized = true;
    }
  }

  onClickMenu(BuildContext context) async {
    final result = await const MenuView().launch(context);
    if (result != null) selectedIndex = result;
    notifyListeners();
  }

  onClickBarcode(BuildContext context) async {
    const QrScannerView().launch(context);
  }

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void handleIncomingLinks(BuildContext context) {
    uriLinkStream.listen((Uri? uri) async {
      if (uri != null) {
        if (uri.toString().contains('zimbo://')) {
          setSelectedIndex(2);

          String urlStr = uri.toString();
          String qrId = '';
          if (urlStr.contains("merchant")) {
            qrId = urlStr.split("code=")[1];
          }

          AddScoreView(
            qrId: qrId,
          ).launch(context);
        }
      }
    }, onError: (Object err) {});
  }

  Future<void> handleInitialUri(BuildContext context) async {
    try {
      var uri = await getInitialLink();
      if (uri != null) {
        if (uri.toString().contains('zimbo://')) {
          setSelectedIndex(2);

          String urlStr = uri.toString();
          String qrId = '';
          if (urlStr.contains("merchant")) {
            qrId = urlStr.split("code=")[1];
          }

          AddScoreView(
            qrId: qrId,
          ).launch(context);
        }
      }
    } on PlatformException {
    } on FormatException {}
  }

  setupNotificationAndroid(BuildContext context) async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'zimbo_channel_id',
      'High Importance Notifications',
      importance: Importance.high,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification_logo');
    var initializationSettings = InitializationSettings(
      android: initialzationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: ColorUtils.appColorAccent,
                icon: "@drawable/ic_notification_logo",
              ),
            ));
      }
    });

    var details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      const SplashView().launch(context);
    }
  }

  setupNotificationIOS(BuildContext context) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    final BehaviorSubject<ReceivedNotification>
        didReceiveLocalNotificationSubject =
        BehaviorSubject<ReceivedNotification>();

    final BehaviorSubject<String?> selectNotificationSubject =
        BehaviorSubject<String?>();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              didReceiveLocalNotificationSubject.add(
                ReceivedNotification(
                  id: id,
                  title: title,
                  body: body,
                  payload: payload,
                ),
              );
            });

    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      selectedNotificationPayload = payload;
      selectNotificationSubject.add(payload);
    });

    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                const SplashView().launch(context);
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });

    var details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      const SplashView().launch(context);
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}
