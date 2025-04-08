// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationManager {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   Future<void> initialize() async {
//     try {
//       await _requestPermissions();
//       FirebaseMessaging.onBackgroundMessage(
//           _firebaseMessagingBackgroundHandler);
//       //initializeLocalNotifications();
//       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//         debugPrint("Handling a foreground message: ${message.messageId}");
//         showLocalNotification(message);
//       });
//     } catch (e) {
//       debugPrint("Failed to initialize Firebase: $e");
//     }
//   }
//
//   Future<void> _requestPermissions() async {
//     NotificationSettings settings =
//         await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     debugPrint('User granted permission: ${settings.authorizationStatus}');
//   }
//
//   Future<void> _firebaseMessagingBackgroundHandler(
//       RemoteMessage message) async {
//     debugPrint("Handling a background message: ${message.messageId}");
//     // Handle background message here if needed
//   }
//
//   void initializeLocalNotifications() async {
//     var initializationSettingsAndroid =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = const DarwinInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveBackgroundNotificationResponse: (payload) async {
//         debugPrint("onDidReceiveBackgroundNotificationResponse $payload");
//       },
//       onDidReceiveNotificationResponse: (payload) async {
//         debugPrint("onDidReceiveNotificationResponse $payload");
//       },
//     );
//   }
//
//   Future selectNotification(String? payload) async {
//     // Handle notification tap
//   }
//
//   void showLocalNotification(RemoteMessage message) async {
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       message.notification!.title,
//       message.notification!.body,
//       platformChannelSpecifics,
//       payload: message.data['payload'], // You can customize payload here
//     );
//   }
//
//   void showTestNotification() {
//     flutterLocalNotificationsPlugin.show(
//       0,
//       'Test Notification',
//       'This is a test notification',
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'your channel id',
//           'your channel name',
//         ),
//       ),
//     );
//   }
// }
