import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:krzv2/services/cache_service.dart';

class PushNotificationService with CacheManager {
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'com.app.KRZ',
    'com.app.KRZ',
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> setupInteractedMessage() async {
    await Firebase.initializeApp();
    setUpLocalNotifications();
    setupFireBaseMessaging();
  }

  setUpLocalNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  setupFireBaseMessaging() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    ///Request notifications permission
    await _firebaseMessaging
        .requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    )
        .then(
      (value) async {

        if (value.authorizationStatus == AuthorizationStatus.authorized) {
          final String? token = await getFCMToken();
          await saveFirebaseToken(token!);

          FirebaseMessaging.instance
              .getInitialMessage()
              .then((RemoteMessage? message) {
            if (message != null) {
            }
          }).catchError((e) {});

          try {
            FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
              RemoteNotification? notification = message.notification;
              AndroidNotification? android = message.notification?.android;

              if (notification != null && android != null) {
                flutterLocalNotificationsPlugin.show(
                  notification.hashCode,
                  notification.title,
                  notification.body,
                  NotificationDetails(
                      android: AndroidNotificationDetails(
                        channel.id,
                        channel.name,
                      ),
                      iOS: DarwinNotificationDetails()),
                );
              }

              if (message.notification != null) {
                print(
                    'Message also contained a notification: ${message.notification}');
              }
              Get.snackbar(
                '',
                '',
                titleText: Text(
                  message.notification?.title ?? '',
                  style: TextStyle(color: Color(0xff008066)),
                ),
                messageText: Text(
                  message.notification?.body ?? '',
                  style: TextStyle(color: Color(0xff008066)),
                ),
                snackPosition: SnackPosition.TOP,
                // icon: Padding(
                //   padding: const EdgeInsets.only(right: 2, left: 2),
                //   child: Image.asset("assets/images/logo_ar.png"),
                // ),
                backgroundColor: Colors.white,
              );
            });
          } catch (e) {
          }

          FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
            print(message.data.toString());
          });

          return;
        }
      },
    );
  }

  Future<String?> getFCMToken() async {
    String? fcmToken;

    try {
      fcmToken = await FirebaseMessaging.instance.getToken();
    } catch (e, st) {
    }

    return fcmToken;
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }
}
