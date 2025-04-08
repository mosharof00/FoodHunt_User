// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:shopaholic/appConfig.dart';
// import '../../helper/log_printer.dart';
//
// class PushNotificationService {
//   static Future<String> getAccessToken() async {
//     // Service Account JSON
//     List<String> scopes = [
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//
//     // Create an authenticated client
//     final client = http.Client();
//     final credentials = await auth.obtainAccessCredentialsViaServiceAccount(
//       auth.ServiceAccountCredentials.fromJson(AppConfig.serviceAccountJson),
//       scopes,
//       client,
//     );
//     client.close();
//
//     return credentials.accessToken.data;
//   }
//
//   static Future<void> sendNotificationToSelectedDriver({
//     required String deviceToken,
//     required BuildContext context,
//     required String currentUserName,
//     required String currentUserMsg,
//   }) async {
//     final String serverKey = await getAccessToken();
//     String endpointFirebaseCloudMessaging =
//         'https://fcm.googleapis.com/v1/projects/${AppConfig.projectID}/messages:send';
//
//     final Map<String, dynamic> message = {
//       'message': {
//         'token': deviceToken.toString(),
//         'notification': {
//           'title': currentUserName,
//           'body': currentUserMsg,
//         },
//       }
//     };
//
//     try {
//       final http.Response response = await http.post(
//         Uri.parse(endpointFirebaseCloudMessaging),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $serverKey',
//         },
//         body: jsonEncode(message),
//       );
//
//       if (response.statusCode == 200) {
//         Log.i('Notification sent successfully');
//       } else {
//         Log.e(
//             'Failed to send notification: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       Log.e('Error sending notification: $e');
//     }
//   }
// }
