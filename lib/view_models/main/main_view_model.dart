import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zimbo/extentions/widget_extensions.dart';
import 'package:zimbo/utils/color_utils.dart';
import 'package:zimbo/view_models/base_view_model.dart';
import 'package:zimbo/views/auth/splash_view.dart';
import 'package:zimbo/views/other/add_score_view.dart';
import 'package:zimbo/views/other/menu_view.dart';
import 'package:zimbo/views/other/qr_scanner_view.dart';

class MainViewModel extends BaseViewModel {
  int selectedIndex = 2;
  bool initialUriIsHandled = false;

  initialize(BuildContext context, int? selectedVal) async {
    if(selectedVal != null){
      selectedIndex = selectedVal;
    }
    
    handleIncomingLinks(context);
    handleInitialUri(context);
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request().then((value) => {
        
      });
    }

    setupNotification(context);
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
      if(uri != null) {
        if(!initialUriIsHandled){
          initialUriIsHandled = true;
          setSelectedIndex(2);
          const AddScoreView().launch(context);
        }
      }
    }, onError: (Object err) {
    });
  }

  Future<void> handleInitialUri(BuildContext context) async {
    try {
      if(!initialUriIsHandled){
        initialUriIsHandled = true;
        final uri = await getInitialUri();
        if (uri == null) {
        } else { 
          setSelectedIndex(2);
          const AddScoreView().launch(context);
        }
      }
        
    } on PlatformException {
    } on FormatException {
    }
  }

  setupNotification(BuildContext context) async {
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

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification_logo');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
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

    var details = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (details!.didNotificationLaunchApp) {
      const SplashView().launch(context);
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
  }
