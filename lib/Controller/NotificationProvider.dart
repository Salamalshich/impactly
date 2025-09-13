import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");

  // عرض الإشعار
  _showNotification(message);
}

// دالة لمساعدة عرض الإشعار
void _showNotification(RemoteMessage message) {
  flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.notification?.title,
    message.notification?.body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'General Notifications',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      ),
    ),
  );
}

class NotificationProvider extends ChangeNotifier {
  String? _deviceToken;
  RemoteMessage? _lastMessage;

  String? get deviceToken => _deviceToken;
  RemoteMessage? get lastMessage => _lastMessage;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log("User granted permission: ${settings.authorizationStatus}");

    // الحصول على Token
    _deviceToken = await _messaging.getToken();
    log("FCM Token: $_deviceToken");

    // تحديث Token
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      _deviceToken = newToken;
      notifyListeners();
      log("Token refreshed: $newToken");
    });

    // Initial Message عند فتح التطبيق من إشعار وهو مسكر
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _lastMessage = initialMessage;
      notifyListeners();
      _showNotification(initialMessage);
    }

    // إشعارات أثناء فتح التطبيق (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _lastMessage = message;
      notifyListeners();
      log("New message: ${message.notification?.title}");
      _showNotification(message);
    });

    // عند الضغط على إشعار أثناء Background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _lastMessage = message;
      notifyListeners();
      log("Opened from notification: ${message.notification?.title}");
    });

    notifyListeners();
  }
}

Future<void> initLocalNotification() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      log('Notification clicked: ${response.payload}');
    },
  );
}
